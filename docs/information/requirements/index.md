# Házi feladat követelmények

## Minimum követelmények

Csak azok az alkalmazások fogadhatóak el, melyek a következő követelmények mindegyikét teljesítik:

- Helyesen működik (nincs kivétel, sárga halál, nem lehet hibás vagy rosszindulatú adatok bevitelével kiakasztani).
- SQL injection és cross-site scripting ellen védett.
- Entity Framework Core használata, legalább 4 adatbázis táblával.
- CSS vagy SCSS használata (igényes kinézet).
- Jogosultág kezelés nem egyedi megoldással, hanem a beépített módon (ASP.NET Identity) és legyen minimum egy anonymous és egy belépett felhasználó, vagy külső identity provider (pl. Facebook, Google, Microsoft Identity) használatával.
- Többrétegű architektúra használata. Külön projektekben (nem könyvárakban).
- Módosítható, nem bedrótozott beállítások (pl. connection string appsettings.json-ban), ha lehet Options minta használata.
- *ASP.NET Razor Pages* vagy *Blazor WASM*-ban készült alkalmazás.

## Megajánlott jegyhez előnyt jelentenek

A következő funkciók megvalósítása segít a megajánlott jegy megszerzésében, de még több implementálása sem garantálja azt:

- Feliratkozás / értesítés küldése
- Összetett keresés / szűrés
- Health monitoring, naplózás (általános hiba, vagy esemény log)
- Többnyelvű felhasználói felület (dinamikusan, nem a kód többszörözésével, elegendő 3 oldalra elkészíteni)
- Blazor WASM használata

    - Kliens oldali API generálása (pl: nswag)
    - Komponens library használata (pl: [Radzen](https://blazor.radzen.com/))

Az itt leírtakon felül természetesen más is figyelembe vehető, ha az valóba extra funkcionalitást ad az alkalmazáshoz.
