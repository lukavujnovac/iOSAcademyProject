# iOSAcademyProject

## Task

Develop an app that tracks NBA season

## Tools used

SnapKit, CoreData, UIKit, FireBase, SDWebImage, UserDefaults

## Architecture

The app was developed bt following MVC (Model-View-Controller) architecture.

## Data Source

Data is fetched from API - https://www.balldontlie.io/#introduction (all players, games and teams) and from API - https://academy-2022.dev.sofascore.com/docs (player images).

## UI
Application creates it's UI using UIKit with additional libraries.

## Bugs
major bugs: After logging in the app displays ExploreVC without tabbar (works after app restart)

minor/solved bugs: Pagingation with players showing all items after paging, when should show only items fetched from new page. (solved with games for teams)


