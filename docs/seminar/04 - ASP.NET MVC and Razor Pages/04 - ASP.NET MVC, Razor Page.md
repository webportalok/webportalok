# ASP.NET Core MVC és Razor Pages

### UI Layer

Mivel a migrációkat nem tudjuk csak a DAL projekttel létrehozni, ezrét kénytelenek vagyunk már most felvenni a UI régetbe a projekttet, ami az alábbiak lehetnek

Ha megnézzük a listát, láthatjuk, hogy igen sokféle kiinduló webes projekt közül választhatunk.

- ASP.NET Core Web App: Egy kiinduló, minta projektet hoz létre Razor Pages-el. (Ezt használjuk a laboron)
- ASP.NET Core Web App (Model-View-Controller): Egy kiinduló, minta projektet hoz létre, mely az MVC mintát használja nem a Razor Pages-t.
- ASP.NET Core Web API: Kiinduló projekt RESTful API készítéshez. Itt nincs megjelenítő réteg csak a Controllerek, amit egy különálló UI réteg (pl. SPA) meg tud hívni.
- ASP.NET Core Empty: Teljesen üres project.


- **ASP.NET Core Web App (Model-View-Controller)**: Szerver oldalon renderelt klasszikus Model-View-Controller architektúra alapú kiinduló projektet hoz létre.
- **ASP.NET Core Web App (Razor Pages)**: Szerver oldalon renderelt alkalmazás, ahol a View és Controller nem különül el, hanem egy Razor fileban szerepel a View és előre meghatározott eseményekre feliratkozva tudunk az interakciókra reagálni.
- **ASP.NET Core Web API**: Kiinduló projekt RESTful API készítéshez. Itt nincs megjelenítési réteg csak a Controllerek, amit egy különálló UI réteg amit egy SPA (pl: Blazor, Angular, React kliens) tud hívni.
- **Blazor Web App**: Kliens oldalon renderelt alkalmazás, ahol a kliens a szerver által kipublikált REST API (Web API) végpontokat hívja. Ez az opció létre hozza a kliens oldali wasm és a szerver oldali API alkalmazást is.
- **Blazor WebAssembly Standalone App**: Ez is egy Blazor web assembly alkalmazást hoz létre, mint a Blazor Web App, viszont ez a szerver oldali projektet nem hozza létre.
- **Blazor Server app**: Szerver oldalon renderent Blazor alkalmazás, ahol a kliens és a szerver SignalR-en keresztül kommunikál. Az eseményeket a szerver kezeli, a szerver HTML-t renderel és a renderelt HTML-t SignalR-en keresztül külni el a kliensnek, hogy az meg tudja jeleníteni.

#### ASP.NET Core MVC

![ASP.NET MVC](images/aspnet-mvc.png)
![ASP.NET MVC settings](images/aspnet-mvc-2.png)

![ASP.NET MVC overview](images/aspnet-mvc-overview.png.png)

#### ASP.NET Razor Page

ASP.NET Core Web App (Razor Page) típust válasszuk.

## Frontend projekt létrehozása

### ASP.NET MVC

### ASP.NET Razor Pages

### Blazor WASM
