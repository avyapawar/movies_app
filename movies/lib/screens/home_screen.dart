import 'package:flutter/material.dart';
import 'package:movies_app/constant/const_color.dart';
import 'package:movies_app/model/search_notifier.dart';
import 'package:movies_app/screens/popular_movies_screen.dart';
import 'package:movies_app/screens/searched_movies_screen.dart';
import 'package:movies_app/screens/top_rated_screen.dart';
import 'package:movies_app/screens/upcoming_movie_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool isSearchFieldVisible = false;

  SearchNotifier searchNotifier = SearchNotifier();
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  bool isvisibleTabBar = true;
  late Size size;

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
 
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
  

    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstColor.appBarBackgroundcolor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 20),
                Text('Movies db',
                    style: TextStyle(color: ConstColor.appBarTextColor)),
                SizedBox(
                  child: SizedBox(
                    width: size.width - 200,
                    height: kToolbarHeight,
                    child: TabBar(
                      indicatorColor: Colors.transparent,
                      controller: _tabController,
                      tabs: isSearchFieldVisible
                          ? getSearchTabTitle()
                          : getAllTabTitless(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: ConstColor.screenBackgroundColor,
      body: TabBarView(
          controller: _tabController,
          children: isSearchFieldVisible ? getSearchTab() : getAllTabs()),
    );
  }

  getAllTabs() {
    return const [
      PopularMoviesScreen(),
      TopRatedScreen(),
      UpcomingScreen(),
      SearchedScreenPage()
    ];
  }

  getSearchTab() {
    return [const SearchedScreenPage()];
  }

  getAllTabTitless() {
    return [
      const Tab(
        text: 'popular',
      ),
      const Tab(
        text: 'top rated',
      ),
      const Tab(
        text: 'upcoming',
      ),
      Tab(
        iconMargin: EdgeInsets.zero,
        child: size.width >= 1300
            ? Container(
                decoration: BoxDecoration(
                    color: ConstColor.searchBarColor, border: Border.all()),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: TextField(
                    
                    controller: searchController,
                    onTap:() {
    _tabController.animateTo(3) ;

                    },
                    onChanged: (value) {
                      setState(() {
                  
                          isSearching = true;
                        
                        searchNotifier.updateSearchData(value);
                      });
                      
                    },
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 5),
                        border: InputBorder.none,
                        hintText: 'Search...',
                        hintStyle: TextStyle()),
                  ),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    isSearchFieldVisible = true;
                    searchController.clear();
                    isSearching = false;
                    searchNotifier.clearSearchData();
                    _tabController = TabController(
                      length: 1,
                      initialIndex: 0,
                      vsync: this,
                    );
                  });
                },
              ),
      )
    ];
  }

  getSearchTabTitle() {
    return [
      Tab(
        child: Row(
        children: [
          Container(
            width: 200,
            decoration: BoxDecoration(
                color: ConstColor.searchBarColor, border: Border.all()),
            child: Padding(
              padding:const EdgeInsets.only(bottom: 8),
              child: TextField(
                enabled: true,
                controller: searchController,
                onChanged: (value) {
                  setState(() {
               
                      isSearching = true;
                  
                  
                    searchNotifier.updateSearchData(value);
                  });
                },
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 5),
                    border: InputBorder.none,
                    hintText: 'Search...',
                    hintStyle: TextStyle()),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                isSearchFieldVisible = false;
                _tabController = TabController(
                  length: 4,
                  initialIndex: 0,
                  vsync: this,
                );
              });
            },
          )
        ],
      ))
    ];
  }
}
