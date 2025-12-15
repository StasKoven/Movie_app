import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pod_player/pod_player.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../data/models/video_model.dart';
import '../bloc/movie_detail_bloc.dart';
import '../bloc/movie_detail_event.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';
import '../../../../shared/widgets/movie_card.dart';
import 'movie_detail_page.dart';

class MoviesWithTrailersPage extends StatefulWidget {
  const MoviesWithTrailersPage({super.key});

  @override
  State<MoviesWithTrailersPage> createState() => _MoviesWithTrailersPageState();
}

class _MoviesWithTrailersPageState extends State<MoviesWithTrailersPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedGenre = 'All';
  int? _selectedYear;
  double _minRating = 0.0;

  final List<String> _genres = [
    'All',
    'Action',
    'Adventure',
    'Animation',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'Horror',
    'Mystery',
    'Romance',
    'Science Fiction',
    'Thriller',
  ];

  final Map<String, int> _genreIds = {
    'Action': 28,
    'Adventure': 12,
    'Animation': 16,
    'Comedy': 35,
    'Crime': 80,
    'Documentary': 99,
    'Drama': 18,
    'Family': 10751,
    'Fantasy': 14,
    'Horror': 27,
    'Mystery': 9648,
    'Romance': 10749,
    'Science Fiction': 878,
    'Thriller': 53,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _loadMovies();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadMovies() {
    final bloc = context.read<MovieBloc>();
    switch (_tabController.index) {
      case 0:
        bloc.add(LoadPopularMovies());
        break;
      case 1:
        bloc.add(LoadTopRatedMovies());
        break;
      case 2:
        bloc.add(LoadUpcomingMovies());
        break;
    }
  }

  List<dynamic> _filterMovies(List<dynamic> movies) {
    var filtered = movies;

    // Filter by genre
    if (_selectedGenre != 'All') {
      final genreId = _genreIds[_selectedGenre];
      if (genreId != null) {
        filtered = filtered.where((movie) {
          final genreIds = movie.genreIds as List<int>;
          return genreIds.contains(genreId);
        }).toList();
      }
    }

    // Filter by year
    if (_selectedYear != null) {
      filtered = filtered.where((movie) {
        final releaseDate = movie.releaseDate as String;
        return releaseDate.startsWith(_selectedYear.toString());
      }).toList();
    }

    // Filter by rating
    if (_minRating > 0) {
      filtered = filtered.where((movie) {
        return (movie.voteAverage as double) >= _minRating;
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MovieBloc>()..add(LoadPopularMovies()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Movies with Trailers',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: _showFilterDialog,
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            tabs: const [
              Tab(text: 'Popular'),
              Tab(text: 'Top Rated'),
              Tab(text: 'Upcoming'),
            ],
          ),
        ),
        body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state.status == MovieStatus.initial) {
            _loadMovies();
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == MovieStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == MovieStatus.failure) {
            return Center(
              child: Text(
                state.errorMessage ?? 'Failed to load movies',
                style: const TextStyle(color: AppColors.error),
              ),
            );
          }

          final filteredMovies = _filterMovies(state.movies);

          if (filteredMovies.isEmpty) {
            return const Center(
              child: Text(
                'No movies found matching your filters',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: filteredMovies.length,
            itemBuilder: (context, index) {
              final movie = filteredMovies[index];
              return MovieCard(
                movie: movie,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => getIt<MovieDetailBloc>()
                          ..add(LoadMovieDetail(movie.id)),
                        child: MovieDetailPage(movieId: movie.id),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setModalState(() {
                        _selectedGenre = 'All';
                        _selectedYear = null;
                        _minRating = 0.0;
                      });
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Genre',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _genres.map((genre) {
                  final isSelected = _selectedGenre == genre;
                  return FilterChip(
                    label: Text(genre),
                    selected: isSelected,
                    onSelected: (selected) {
                      setModalState(() {
                        _selectedGenre = genre;
                      });
                      setState(() {});
                    },
                    backgroundColor: AppColors.background,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              const Text(
                'Minimum Rating',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Slider(
                value: _minRating,
                min: 0,
                max: 10,
                divisions: 10,
                label: _minRating.toStringAsFixed(1),
                activeColor: AppColors.primary,
                onChanged: (value) {
                  setModalState(() {
                    _minRating = value;
                  });
                  setState(() {});
                },
              ),
              Text(
                'Rating: ${_minRating.toStringAsFixed(1)}+',
                style: const TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Apply Filters'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrailerPlayerPage extends StatefulWidget {
  final VideoModel video;

  const TrailerPlayerPage({super.key, required this.video});

  @override
  State<TrailerPlayerPage> createState() => _TrailerPlayerPageState();
}

class _TrailerPlayerPageState extends State<TrailerPlayerPage> {
  late PodPlayerController _controller;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    final videoId = widget.video.key;
    
    try {
      _controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(
          'https://www.youtube.com/watch?v=$videoId',
        ),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: true,
          isLooping: false,
          videoQualityPriority: [720, 480, 360],
        ),
      );
      
      await _controller.initialise();
      
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to load video: $e';
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          widget.video.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: _isLoading
                  ? Container(
                      color: Colors.black,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : _errorMessage != null
                      ? Container(
                          color: Colors.black,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  color: AppColors.primary,
                                  size: 48,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  _errorMessage!,
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      : PodVideoPlayer(
                          controller: _controller,
                          videoAspectRatio: 16 / 9,
                          alwaysShowProgressBar: true,
                        ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.video.name,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.play_circle_outline,
                                size: 16,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.video.type,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.videocam,
                                size: 16,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.video.site,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
