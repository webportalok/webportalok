# MS SQL ADATBÁZIS ÉS EF ALAPOK

## Bevezetés

A labor célja, az MS SQL Server ismeretek átismétlése, illetve azon hallgatóknak akik még nem foglalkoztak adatbázisokkal a gyakorlatban megmutassuk, hogyan lehet táblákat létrehozni, lekérdezéseket és tárolt eljárásokat készíteni.
A labor során a hallgatók egy-egy példán keresztül ismerkednek meg a Táblalétrehozást, adatbázis lekérdezések és módosítások készítését, valamint a tárolt eljárások írását.

## Adatbázis létrehozása

1. Indítsuk el a Microsoft SQL Server Management Studiot-t, majd csatlakozzunk a lokális adatbázis szerverhez, amit a `(localdb)\MSSQLLocalDB` névvel érünk el.

- A lokális adatbázis szerver nem teljes SQL szerver és tipikusan fejlesztéshez érdemes használni. A Visual Studio alapértelmezés szerint feltelepíti.
- Ha a „nagy” SQL szerverhez szeretnénk kapcsolódni, ami a lokális gépen fut, akkor a . (pontot) adjuk meg mint szervernév. Ezt külön telepíteni kell.

1. Az Object explorerben jobb klikk a Databases-re és válasszuk a New Database opciót, majd adjuk meg az adatbázis nevét, ami legyen TesztDB. Bal oldalon még az Options fül lehet érdekes, ahol számos adatbázis beállítást meg lehet adni, de ezeket most nem módosítjuk, jó az alapértelmezett beállítás.

1. Az Ok-ra kattintva létrejön az adatbázis és az Object Explorerben a Databases alatt meg is jelenik.
