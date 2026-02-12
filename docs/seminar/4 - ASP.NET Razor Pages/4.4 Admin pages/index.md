# 4.4. Admin oldalak

## Kategóriák szerkesztése

A *ManageCategories* oldalt már létrehoztuk, most készítsük is el úgy, hogy a bal oldalon megjelenik a kategória fa ViewComponent, a jobb oldalon pedig attól függően, hogy választottunk-e ki kategóriát a szerkesztés vagy új felvitele rész.

A kategória menedzselésénél a *kategória nevét*, a *szülő kategóriát* és a *sorrendet* szeretnénk beállítani, illetve az Id-ra lesz szükség, hogy el tudjuk dönteni, hogy szerkesztésről vagy új kategória felviteléről van szó.

Jelenleg a `CategoryService`-ben a `GetCategoryTreeAsync()` egy `CategoryData` listát ad vissza, amiben csak azok az adatok szerepelnek, amire a kategória fa kirajzolásánál szükség van. Lehetne bővíteni ezt a DTO-t, hogy a kategória szerkesztésre és létrehozásra is alkalmas legyen (kvázi minden adatot tartalmaz), azonban szerencsésebb ha külön DTO-t hozunk erre létre, mert így átláthatóbb a kód és a validációs szabályokat is rá tudjuk tenni.  
Abban az esetben ha csak bizonyos mezők lennének szerkeszthetők, akkor még a létrehozáshoz és módosításhoz használ DTO-kat is külön érdemes felvenni. Így a kód átláthatósága növelhető.

1. A megvalósításhoz a DTO és szolgáltatás osztályok már készen vannak, nézzük is át, hogy mit kell használni.
    - Az összes kategóriát a `CategoryService`-ben található `GetCategoryTreeAsync()` segítségével tudjuk lekérdezni.
    - A `CategoryService`-ben található `AddOrUpdateAsync` metódussal tudunk új kategóriát létrehozni, vagy egy meglévőt módosítani. Attól függ, hogy szerkesztjük vagy létrehozzuk a kategóriát, hogy az Id ki van-e töltve. A metódus egy `CreateOrEditCategory` DTO-t vár ami alapján létrehozza a `Category` entitást és beszúrja az adatbázisba, majd visszaadja a `CategoryData`-t. Ezt most nem fogjuk kihasználni, de egy Blazor alkalmazás esetén hasznos lehet, hogy nem kell a teljes kategóriafát újratölteni, hiszen az újonnan beszúr kategória adatait egyből visszakapjuk.
    - Figyeljük meg, hogy a `CreateOrEditCategory` DTO-ba nem vettük fel a `Level`-t hiszen az egy számított tulajdonság, illetve a validációhoz szükséges annotációkat is elkészítettük.

2. A fentiek alapján készítsük el a `ManageCategories` oldalt is. Kezdjük az adatbetöltéssel.
    - A primary konstruktorban várjuk az `ICategoryService`-t.
    - Az oldalnak szüksége lesz egy `CategoryId`-ra illetve egy Category-ra amit adatkötni kell. Ebben tároljuk a szerkesztéshez kiválasztott kategóriát, ami lehet null hiszen a létrehozásnál nem lesz kategória kiválasztva.
    - Az `OnGetAsync()`-ban pedig először le kell kérni az összes kategóriát, hogy a dropdown listát fel tudjuk tölteni elemekkel, illetve attól függően, hogy a CategoryId ki van-e töltve le kell kérdezni a módosítandó kategóriát.

    ``` csharp title="ManageCategories.cshtml.cs" hl_lines="9 13-14 16-17 21 29-30"
    using BookShop.Bll.ServicesInterfaces;
    using BookShop.Transfer.Dtos;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.RazorPages;
    using Microsoft.AspNetCore.Mvc.Rendering;

    namespace BookShop.Web.RazorPage.Pages.Admin;

    public class ManageCategoriesModel(ICategoryService categoryService) : PageModel
    {
        public IEnumerable<SelectListItem> AllCategories = [];

        [BindProperty(SupportsGet = true)]
        public int? CategoryId { get; set; }

        [BindProperty]
        public CreateOrEditCategory Category { get; set; } = new CreateOrEditCategory();

        public async Task OnGetAsync()
        { 
            var categoryList = await categoryService.GetCategoryTreeAsync();

            // Create list for dropdown, indenting names based on level
            AllCategories = categoryList.Select(c => new SelectListItem { 
                Text = c.Name.PadLeft(c.Name.Length + c.Level * 2, '\xA0'), 
                Value = c.Id.ToString() 
            }); 
            
            if (CategoryId.HasValue) 
                Category = await categoryService.GetCategoryForEditAsync(CategoryId.Value); 
        }
    }
    ```

3. Készítsük el az oldalhoz a cshtml-t is az alábbiak szerint.
    - Bal oldalra kerüljön a categoryList ViewComponent.
    - Jobb oldalon pedig kérjük be az alábbi adatokat, amit a SelectedCategory-hoz kell kötni
        - `Name` - szövegdoboz
        - `ParentCategoryId` – Dropdown lista, amiben az `AllCategories` adja meg a lehetséges elemeket
        - `Order` – szövegdoboz.
        - Létrehozás / Módosítás / Mégsem / Törlés gomb a megfelelő `asp-handler` beállításával.

    ``` aspx-cs title="ManageCategories.cshtml" hl_lines="9 13 16 18 22 25-28 32 36-38 42 44"
    @page
    @model BookShop.Web.RazorPage.Pages.Admin.ManageCategoriesModel

    <h2>Kategóriák menedzselése</h2>
    <p>Az adminisztrátorok itt hozhatnak létre új kategóriát, vagy módosíthatják / törölhetik a meglévőket.</p>

    <div class="row">
        <div class="col-md-3">
            <vc:category-list category-id="@Model.CategoryId" />
        </div>

        <div class="col-md-9">
            <h2>@(Model.CategoryId.HasValue ? "Kategória módosítása" : "Új kategória felvitele")</h2>

            <form method="post" class="form-horizontal" role="form">
                <div asp-validation-summary="All" class="text-danger"></div>

                <input type="hidden" asp-for="Category.Id" />

                <div class="form-floating mb-3">
                    <input class="form-control" asp-for="Category.Name" placeholder=" " />
                    <label asp-for="Category.Name">Kategória neve</label>
                </div>
                <div class="form-floating mb-3">
                    <select class="form-select" asp-for="Category.ParentCategoryId" asp-items="Model.AllCategories">
                        <option value="">Nincs</option>
                    </select>
                    <label asp-for="Category.ParentCategoryId">Szülő kategória</label>
                </div>
                <div class="form-floating mb-3">
                    <input class="form-control" asp-for="Category.Order" placeholder=" " />
                    <label asp-for="Category.Order">Sorrend</label>
                </div>

                <div class="d-flex justify-content-between">
                    <button asp-page-handler="AddOrUpdate" class="btn btn-primary">
                        @(Model.Category.Id.HasValue ? "Módosítás" : "Létrehozás")
                    </button> 
                    
                    @if (Model.Category.Id.HasValue) 
                    {
                        <button asp-page-handler="Cancel" class="btn btn-dark">Mégsem</button>

                        <button asp-page-handler="Delete" class="btn btn-danger">Törlés</button>
                    }
                </div>
            </form>
        </div>
    </div>
    ```

    Figyeljük meg a kódban az alábbiakat:

      - `@if` részeket, amivel feltételesen tudunk tartalmat megjeleníteni.
      - A `<select>` tag létrehozását.
      - Az `asp-page-handler` használatát
      - Az `asp-validation-summary`-t a form tagen belülre helyezzük el.
      - AntiForgeryToken-t nem használunk, mert az alapértelmezés szerint rákerül a form-ra.

        ??? Note "Több sumbit gomb kezelése"
            Ha egy űrlapon több submit gomb található akkor az `asp-page-handler` segítségével tudunk köztünk különbséget tenni. A cshtml.cs-ben pedig az `OnPostXYZ` metódusokkal tudjuk kezelni, ahol az XYZ az `asp-page-handler`-ben megadott rész.

4. Ha így elindítjuk az alkalmazást, akkor azt tapasztaljuk, hogy tényleg csak Admin érheti el az oldalt és a linket is, ehhez lépjünk be az admin felhasználóval (admin@exmaple.com / *Password123!*)  
Alapértelmezés szerint az új kategória létrehozása tölt be, de ha rákattintunk egy kategóriára akkor átvált módosításra.

5. Ezt követően már csak annyi dolgunk van, hogy a form postolást szerver oldalok kezeljük, tehát megvalósítjuk az *új kategória létrehozásához*, *módosításához*, *törléséhez* és *mégsem* gombhoz szükséges kódot.

    - A létrehozás és módosítást ugyanaz a gomb kezeli, csak más a felirata. Ennek a gombnak az `asp-page-hander="AddOrUpdate"` van megadva, tehát ehhez kell elkészíteni a megfelelő metódust, aminek a neve `OnPostAddOrUpdate` vagy ha aszinkron akkor `OnPostAddOrUpdateAsync` kell legyen.

        ``` csharp title="ManageCategories.cshtml.cs - OnPostAddOrUpdateAsync"
        public async Task<IActionResult> OnPostAddOrUpdateAsync()
        {
            if (ModelState.IsValid) 
            { 
                await categoryService.AddOrUpdateAsync(Category); 
                return new RedirectToPageResult("/Admin/ManageCategories"); 
            } 
            
            // TODO: Hiba esetén a Model-t újra betölteni.
            return Page(); 
        }
        ```

    - Mégsem gomb csak null-ra állítja a kiválasztott `CategoryId`-t

        ``` csharp title="ManageCategories.cshtml.cs - OnPostCancelAsync"
        public async Task<IActionResult> OnPostCancelAsync()
        {
            CategoryId = null;

            return new RedirectToPageResult("/Admin/ManageCategories");
        }
        ```

    - Hasonlóan a létrehozáshoz készítsük el a törés gomb eseménykezelőjét is.

        ``` csharp title="ManageCategories.cshtml.cs - OnPostDeleteAsync"
        public async Task<IActionResult> OnPostDeleteAsync() 
        { 
            if (Category.Id.HasValue) 
                await categoryService.DeleteAsync(Category.Id.Value); 
            
            return new RedirectToPageResult("/Admin/ManageCategories"); 
        }
        ```

    ??? tip "Entitás törlése PK alapján"
        Figyeljük meg a `CategoryService.DeleteAsync()` kódjában, hogy a kódban nem kérdeztük le a kategóriát az adatbázisból, hanem csak létrehoztunk egy új `Category`-t, aminek az `Id`-ját (Primary key) állítottuk be és ez alapján töröltük a rekordot az adatbázisból. Így egy adatbázishoz fordulást meg tudunk spórolni.  
        A kikommentezett sorban látható az a megoldás, ahol először lekérdezzük adatbázisból a rekordot és ezt követően töröljük.

6. Indítsuk el az alkalmazást és vegyünk fel egy kategóriát, megadva minden adatát, majd szerkesszük meg és töröljük. Ezzel a happy path-t le is teszteltük.
7. De mi a helyzet akkor nem adjuk meg a kategória nevét?  
Ha nem adtunk volna meg validációs szabályokat akkor az adatbázis constraint miatt kapnánk hibát. Viszont mivel felvettük a kötelező mezőkhöz a `[Required]` attribútumokat így szép validációs hibát kapunk.
8. Fontos, hogy a szerver oldali validáció a `Model.IsValid` hívás miatt fut le. Erre mindig figyelni kell. Viszont hiba esetén eltűnnek a Szülő kategória elemei. Ennek az az oka, hogy csak az `OnGetAsync()`-ban töltjük fel az `AllCategories`-t. A megoldás annyi, hogy akkor is töltsük fel, ha validációs hiba van. Ennek a legegyszerűbb módja, ha készítünk egy `LoadModelAsync()` metódust és oda szervezzük ki az összes ilyen adatfeltöltést, és ezt hívjuk az `OnGetAsync()`-ban és mindenhol ahol újra fel kell tölteni az adatokat.

    ``` csharp title="ManageCategories.cshtml.cs" hl_lines="3 9-19 30"
    public async Task OnGetAsync()
    {
        await LoadModelAsync();

        if (CategoryId.HasValue) 
            Category = await categoryService.GetCategoryForEditAsync(CategoryId.Value); 
    }

    private async Task LoadModelAsync()
    {
        var categoryList = await categoryService.GetCategoryTreeAsync();

        // Create list for dropdown, indenting names based on level
        AllCategories = categoryList.Select(c => new SelectListItem
        {
            Text = c.Name.PadLeft(c.Name.Length + c.Level * 2, '\xA0'),
            Value = c.Id.ToString()
        });
    }

    public async Task<IActionResult> OnPostAddOrUpdateAsync()
    {
        if (ModelState.IsValid) 
        { 
            await categoryService.AddOrUpdateAsync(Category); 
            return new RedirectToPageResult("/Admin/ManageCategories"); 
        }

        // Load the model if any validation error occurs, otherwise the dropdown will be empty and the page will not render correctly
        await LoadModelAsync();
        return Page(); 
    }
    ```

### Kliens oldali validáció

Már majdnem készen is vagyunk, viszont érdemes lenne a validációkat kliens oldalon is kiértékelni. Ezt a [jquery validate](https://jqueryvalidation.org/) segítségével lehet megtenni, amit a `_ValidationScriptsPartial.cshtml`-ben lévő kódrészlet tud beemelni. Ebben a fájlban vannak a validációhoz szükséges JavaScript fájlok behivatkozva. Azért egy külön partial view-ban, hogy csak azokon az oldalakon töltsük be, ahol tényleg szükséges.

Az oldalainknak a váza a `_Layout.csml` fájlt található. Itt töltjük be azokat a CSS és JS fájlokat, ami minden oldalon szükséges és itt adjuk meg az oldal elrendezését is.

Két kódsort érdemes kiemelni.

- A `@RenderBody()` helyére kerülnek be az oldalak (például a `Book.cshtml`)
- Az oldal alján lévő `@await RenderSectionAsync("Scripts", required: false)` pedig egy opcionális `Scripts` nevű szekciót hoz létre. Így az oldalon jelen esetben a `ManageCategories.cshtml` ha létrehozunk egy ilyen nevű szekciót, akkor annak a tartalma ide fog bekerülni.

Tehát a megoldás annyi, hogy a `ManageCategories.cshtml` oldal aljára tegyük oda az alábbi kódrészletet.

``` aspx-cs title="ManageCategories.cshtml"
@section Scripts {
    <partial name="_ValidationScriptsPartial" />
}
```

Így futtatva a kódot már megtörténik a kliens oldali validációs is, sőt mivel már kliens oldalon kiderül a hiba el sem jut a szerverre a kérés, így a legördülőben lévő elemek is megmaradnak. Természetesen a `LoadModelAsync()` megoldásra így is szükség van, mert elképzelhető, hogy bizonyos hibák csak szerver oldalon derülnek ki, tehát érdemes ezt a gyakorlatot követni.

??? success "Ha mindent jól csináltunk az alábbi oldalt kapjuk"
    ![Manage categories final](images/manage-categories-final.png)
    /// caption
    A kategória menedzselő oldal kliens oldali validációval
    ///

## Könyvek szerkesztése

1. A kezdő oldalon a kategória könyvek láblécébe az ár mellé az admin felhasználónak tegyünk ki egy szerkesztés gombot, ami ugyanúgy a `ManageBooks` oldalra visz minket a kiválasztott könyv `Id`-jával, így a könyv szerkesztés / törlés is elérhető lesz navigációval.

    ``` aspcx-cs title="Index.cshtml" hl_lines="1-5"
    <div class="card-footer d-flex justify-content-evenly text-muted fw-bold small">
        @if (User.IsInRole("Admin"))
        {
            <a asp-page="/Admin/ManageBooks" asp-route-bookId="@book.Id"><i class="bi bi-pencil-fill"></i></a>
        }
        @(book.DiscountedPrice ?? book.Price)&nbsp;Ft
    </div>
    ```

    ??? success "Könyv szerkesztés gomb"
        ![Book edit button](images/book-with-edit-button.png)
        /// caption
        Szerkesztés gomb a könyv alatt
        ///

2. Hozzunk létre a `BookShop.Web.RazorPage` projektben a `Settings` mappa alatt egy `FileSettings` osztályt, amibe a file feltöltéssel kapcsolatos beállításokat fogjuk felolvasni az `appsettings.json`-ból.

    ``` csharp title="FileSettings.cs"
    namespace BookShop.Web.RazorPage.Settings;

    public class FileSettings
    {
        public int FileSizeLimit { get; set; }
        public List<string> PermittedExtensions { get; set; } = [];
    }
    ```

3. Adjuk hozzá az `appsettings.json`-höz a beállítás értékeit A ConnectionStrings mögé. Azért nem az *appsettings.Development.json*-ba tesszük mert ez a beállítás minden környezetben azonos lesz.

    ``` json title="appsettings.json"
    "FileSettings": {
        "FileSizeLimit": 2097152,
        "PermittedExtensions": [ ".jpg" ]
    },
    ```

4. A `Program.cs`-t egészítsük ki, hogy ezt az Options-t is felolvassa. A kódot közvetlenül az `EmailSettings` felolvasása után tegyük.

    ``` csharp title="Program.cs"
    builder.Services.Configure<FileSettings>(builder.Configuration.GetSection("FileSettings"));
    ```

5. Készítsük el az oldal kódját
    - Az oldal vár egy opcionális BookId-t az URL-ben (GET esetén)
    - Itt is egy külön DTO-t használunk a `CreateOrEditBook`-ot, amit bind-olni kell.
    - A kép feltöltéshez is szükséges egy `IFormFile` típusú paraméter, amit bind-olni kell.
    - A kategóriák és kiadók kiválasztását egy dropdown listában szeretnénk megjeleníteni, így le kell kérdezni az összes kategóriát és kiadót is.
    - Használjuk itt is a `LoadModelAsync`-os megoldást.
    - Ha van BookId, akkor kérdezzük le a szervertől az adatait `CreateOrEditBook` típus.
    - Az `OnPostAddOrUpdateAsync` kicsivel összetettebb a képfeltöltés miatt.

        - Validáljuk a Model-t,
        - Ha töltünk fel képet, de a kiterjesztése nem szerepel az `appsettings.json`-ban megadott listában akkor adjunk vissza validációs hibát.
        - Mentsük el a könyv adatait a `BookService`-ben már létező `AddOrUpdateAsync` metódussal.
        - Ha töltünk fel képet, akkor mentsük is le a fájlrendszerbe.
        - Végül irányítsuk vissza a felhasználót az `Index` oldalra.

      - A `OnPostDeleteAsync()` a sikeres törlés után irányítson vissza az `Index` oldalra.

    ``` csharp title="ManageBooks.cshtml.cs" hl_lines="11 19-20 22-23 28-29 50 52 55 65-67 81"
    using BookShop.Bll.ServicesInterfaces;
    using BookShop.Transfer.Dtos;
    using BookShop.Web.RazorPage.Settings;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.RazorPages;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.Extensions.Options;

    namespace BookShop.Web.RazorPage.Pages.Admin;

    public class ManageBooksModel(IBookService bookService, ICategoryService categoryService, IPublisherService publisherService,
        IOptions<FileSettings> fileSettingsOptions, IWebHostEnvironment environment) : PageModel
    {
        private readonly IBookService bookService = bookService;
        private readonly ICategoryService categoryService = categoryService;
        private readonly IPublisherService publisherService = publisherService;
        private readonly IWebHostEnvironment environment = environment;

        // Must be public to be able to access from cshtml.
        public readonly FileSettings FileSettings = fileSettingsOptions.Value;

        [BindProperty(SupportsGet = true)]
        public int? BookId { get; set; }

        [BindProperty]
        public CreateOrEditBook Book { get; set; } = new() { PublishYear = DateTime.Now.Year };

        [BindProperty]
        public IFormFile? CoverImage { get; set; }

        public IEnumerable<SelectListItem> AllCategories { get; set; } = [];
        public IEnumerable<SelectListItem> AllPublishers { get; set; } = [];

        public async Task OnGetAsync()
        {
            await LoadModelAsync();

            if (BookId.HasValue)
                Book = await bookService.GetBookForEditAsync(BookId.Value);
        }

        public async Task<IActionResult> OnPostAddOrUpdateAsync()
        {
            if (!ModelState.IsValid)
            {
                await LoadModelAsync();
                return Page();
            }

            var ext = Path.GetExtension(CoverImage?.FileName)?.ToLowerInvariant();

            if (CoverImage is not null && !FileSettings.PermittedExtensions.Contains(ext ?? ""))
            {
                // Add validation error if the file extension is not permitted.
                ModelState.AddModelError("CoverImage", "A kép kiterjesztése nem megfelelő.");

                await LoadModelAsync();
                return Page();
            }

            var updatedBook = await bookService.AddOrUpdateAsync(Book);

            if (CoverImage?.Length > 0)
            {
                var filePath = Path.Combine(this.environment.WebRootPath, $"images/covers/{updatedBook.Id}{ext}");
                using var stream = System.IO.File.Create(filePath);
                await CoverImage.CopyToAsync(stream);
            }

            return new RedirectToPageResult("/Index");
        }

        public async Task<IActionResult> OnPostDeleteAsync()
        {
            if (Book?.Id is not null)
                await bookService.DeleteAsync(Book.Id.Value);

            return new RedirectToPageResult("/Index");
        }

        private async Task LoadModelAsync()
        {
            var categoryList = await categoryService.GetCategoryTreeAsync();

            AllCategories = categoryList.Select(c => new SelectListItem
            {
                Text = c.Name.PadLeft(c.Name.Length + (c.Level - 1) * 3, '\xA0'),
                Value = c.Id.ToString()
            });

            AllPublishers = (await publisherService.GetAllPublishersAsync()).Select(c => new SelectListItem
            {
                Text = c.Name,
                Value = c.Id.ToString()
            });
        }
    }
    ```

    - Figyeljük meg hogy a DI-tól elkértük az `IWebHostEnvironment`-et is, hogy amikor a képet lementjük ismerjük a `wwwroot` könyvtár fizikai helyét. 
    - A `FileSettings` publikus lett, hogy a file input tagben le tudjunk szűrni majd az engedélyezett kiterjesztésekre.

6. Készítsük el az oldal megjelenítését is.

    - Az URL-ben várjuk a bookId-t ami opcionális és egész szám
    - Az oldal címe változzon, hogy "Könyv szerkesztése" vagy "Új könyv felvitele"
    - A `form` tagben meg kell adni az `enctype="multipart/form-data"`, hogy tudjunk fájlt feltölteni.
    - Tegyünk ki validation summary-t.
    - Bal oldalon szerepeljenek a könyv adatai:

        - *kiadó*: legördülő lista, 
        - *kategória*: legördülő lista, a kiadóval egy sorban
        - *kiadás éve*: number típusú
        - *oldalszám*: number típusú és a kiadás évével egy sorban.
        - *cím*: sima input.
        - *alcím*: sima input.
        - *fülszöveg*: text area

    - Jobb oldalon a kép feltöltés, ár és kedvezményes ár legyen.
    - Létrehozás / Módosítás illetve Törlés gombok a megfelelő `asp-page-handler`-rel.

    ``` aspx-cs title="ManageBooks.cshtml" hl_lines="1 7 10 17-22 68 88-90 94"
    @page "{bookId:int?}"
    @model BookShop.Web.RazorPage.Pages.Admin.ManageBooksModel

    <h1>Könyvek kezelése</h1>
    <h2>@( Model.BookId.HasValue ? "Könyv szerkesztése" : "Új könyv felvitele")</h2>

    <form method="post" enctype="multipart/form-data" class="form-horizontal" role="form">
        <div asp-validation-summary="All" class="text-danger"></div>

        <input type="hidden" asp-for="Book.Id" />

        <div class="row g-4">
            <div class="col-md-8">
                <h4>Alapadatok</h4>
                <div class="row g-3">
                    <div class="col-lg-6">
                        <div class="form-floating mb-3">
                            <select class="form-select" asp-for="Book.PublisherId" asp-items="Model.AllPublishers">
                                <option value="">Nincs</option>
                            </select>
                            <label asp-for="Book.PublisherId">Kiadó</label>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="form-floating mb-3">
                            <select class="form-select" asp-for="Book.CategoryId" asp-items="Model.AllCategories">
                                <option value="">Nincs</option>
                            </select>
                            <label asp-for="Book.CategoryId">Kategória</label>
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-floating mb-3">
                            <input class="form-control" asp-for="Book.PublishYear" placeholder=" " />
                            <label asp-for="Book.PublishYear">Kiadás éve</label>
                        </div>
                    </div>

                    <div class="col-6">
                        <div class="form-floating mb-3">
                            <input class="form-control" asp-for="Book.PageNumber" placeholder=" " />
                            <label asp-for="Book.PageNumber">Oldalszám</label>
                        </div>
                    </div>
                </div>

                <div class="form-floating mb-3">
                    <input class="form-control" asp-for="Book.Title" placeholder=" " />
                    <label asp-for="Book.Title">Cím</label>
                </div>

                <div class="form-floating mb-3">
                    <input class="form-control" asp-for="Book.Subtitle" placeholder=" " />
                    <label asp-for="Book.Subtitle">Alcím</label>
                </div>

                <div class="form-floating mb-3">
                    <textarea class="form-control" asp-for="Book.ShortDescription" rows="10" placeholder=" "></textarea>
                    <label asp-for="Book.ShortDescription">Fülszöveg</label>
                </div>
            </div>

            <div class="col-md-4">
                <h4>Borítókép</h4>
                <div class="mb-3">
                    <input class="form-control" asp-for="CoverImage" accept="@string.Join(',', Model.FileSettings.PermittedExtensions)" />
                </div>

                <div class="row g-3">
                    <div class="col-6">
                        <div class="form-floating">
                            <input class="form-control" asp-for="Book.Price" placeholder=" " />
                            <label asp-for="Book.Price">Ár</label>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="form-floating">
                            <input class="form-control" asp-for="Book.DiscountedPrice" placeholder=" " />
                            <label asp-for="Book.DiscountedPrice">Kedv. ár</label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="d-flex justify-content-between">
                <button asp-page-handler="AddOrUpdate" class="btn btn-primary">
                    @(Model.BookId is null ? "Létrehozás" : "Módosítás")
                </button>

                @if (Model.BookId.HasValue)
                {
                    <button asp-page-handler="Delete" class="btn btn-danger">Törlés</button>
                }
            </div>
        </div>
    </form>


    @section Scripts {
        <partial name="_ValidationScriptsPartial" />
    }
    ```

    - Figyeljük meg, hogy itt is használjuk a kliens oldali validációt.

??? success "Könyv módosítása"
    ![Edit book](images/book-edit.png)
    /// caption
    Könyv szerkesztése
    ///

??? success "Új könyv létrehozása"
    ![alt text](images/book-creating-validation-error.png)
    /// caption
    Könyv létrehozása validációs hibák.
    ///

??? success "Létrehozott új könyv"
    ![Book created](images/book-creted-successfully.png)
    /// caption
    Sikeresen létrehozott könyv
    ///
