# Webportálok fejlesztése

## Célkitűzés

A tárgy keretében a hallgatók megismerkednek a modern webes portálokkal szemben támasztott követelményekkel, és megoldásokat látnak azok gyakorlati megvalósítására. A cél, hogy a hallgató a webes portálokat komplex, a gyakorlatban általában kritikus fontosságú megoldásként lássa, ismerje az ilyen jellegű projektekhez tartozó problémaköröket, és tisztában legyen a lehetséges megoldási módokkal.

A tárgy átfogó és teljes képet ad a portálok különböző felhasználási területeiről, külön hangsúlyt fektetve az architektúra, a teljesítmény és a biztonság kérdéseire.

A tárgyhoz kapcsolódó online laborok során a hallgatók számára lehetőség nyílik az előadás anyagának gyakorlati alkalmazására is ASP.NET Core 10 és Blazor WASM segítségével, így a félév végére az ASP.NET Core és Balzor WASM által nyújtott teljes palettát megismerhetik a *Webportálok fejlesztése* című tárgyat választó hallgatók.

A laborok során két komplex alkalmazást készítünk el. Egy ASP.NET Razor Page alapút és egy Blazor WebApp alapút.
A feladatot a funkciók, felületek és adatbázis tervezéstől, az alkalmazás teljes megvalósításáig mely során a hallgatók egyre mélyebben ismerhetik meg az ASP.NET lehetőségeit és kihívásait, hogy a félév végére egy komplex ASP.NET Core Razor Page vagy egy Blazor WebApp webalkalmazást tudjanak önállóan elkészíteni, amit a félév végén nagyházi feladat formájában prezentálni is kell.

## Mi az ASP.NET Core?

A .NET Core a Microsoft nyílt forráskódú, több platformon is (Windows, Linux, OS X) futtatható alkalmazásfejlesztési környezete. Az ASP.NET Core pedig ennek a technológiának a felhasználásával Windows-on, Linux-on és Mac OS-en futtatható webalkalmazások fejlesztésére szolgáló eszköz.

Az ASP.NET Core 10 jelenleg a Microsoft legújabb webfejlesztő eszköze, amit Visual Studio Code vagy Visual Studio 2026 segítségével fejleszthetünk.

## Miért időtálló technológia a webes világban az ASP.NET?

2002-ben jelent meg először az ASP.NET 1.0, azóta kisebb átnevezésekkel, mint ASP.NET MVC vagy ASP.NET Core MVC még mindig virágzik.

Kicsit zavaróak lehetnek az elnevezések, hiszen a Core elnevezés is csak egy marketing fogás miatt került be az elnevezésbe, sugallva az újat, mint sem egy egyszerű főverziószámot növeltek. A .NET 10 megjelenésével viszont ismét eltűnt a Core szó a megnevezésből.

Az alábbi ábrán látható a Microsoft webes technológiájának, az ASP.NET-nek a fejlődése a megjelenéstől napjainkig.

![ASP.NET timeline](images/asp-net-timeline.png)

## Az ASP.NET mely részeit fogjuk használni a laborokon?
A rövid válasz, hogy mindegyiket.

Razor szintaxissal készített szerver oldalon renderelt nézetek két típusa (Razor Pages és Razor MVC).
WebAPI készítése kliens oldali keretrendszerekhez, melyek JSON-ban adják vissza az adatokat például egy Angular vagy mobil kliensnek.
ASP.NET Core Identity a felhasználó- és jogosultságkezelés megvalósításához.
Újrahasznosítható komponensek (View components, Tag helpers) készítése.
Modellvalidáció szerver és kliens oldalon.
Aszinkron felhasználói felületek megvalósítása.
SignalR a valós idejű kommunikációhoz.
SEO lehetőségei
 
Ezen felül ahhoz, hogy teljes értékű alkalmazást tudjunk készíteni a laborokon - nem pedig egyszerű, különálló példákat -, az alábbi technológiákat használjuk fel:
HTML, CSS, JavaScript, jQuery (Mobil és webes szoftvereken elsajátítható)
SQL és Entity Framework Core az adatelérési réteg megvalósításához

## Előtanulmányi rend

A tárgy felvételéhez kötelező előtanulmányi rend nincsen. A tárgy a C# nyelv és a HTML, CSS és JavaScript nyelv alapjainak ismeretére épít, így felvétele csak azon hallgatók számára ajánlott, akik ezekkel a technológiákkal tisztában vannak (a Mobil- és webes szoftverek címtű tárgyon elhangozztak ismerete elegendő a HTML, CSS és JavaScript nyelvekből). Ezen nyelvek ismerete szükséges a tárgy teljesítéséhez, viszont a tárgy ezekkel bevezető szinten sem foglalkozik, hiszen kötelező tárgyak formájában elsajátíthatók.

## A tárgy teljesítésének feltételei

Házi feladat specifikáció benyújtása a gyakorlatvezetőnek a tárgy honlapján keresztül a 10. oktatási hét végéig. A specifikációval és a házi feladat követelményekkel kapcsolatban a tárgy honlapján útmutató található. Csak ASP.NET-ben írt és a honlapon feltöltött (nem e-mailben küldött) házi feladatot tudunk elfogadni. A specifikáció késedelmes benyújtása a leadási határidőt követő hét péntek 23:59-ig lehetséges.
Házi feladat bemutatása a gyakorlatvezetőnek kizárólag az előre meghirdetett időpontokban (az időpontok meghirdetése gyakorlatokon és a tárgy honlapján keresztül történik). A házi feladat késedelmes benyújtására pótlási hét csütörtökön 12:15-től van lehetőség. A specifikáció és a házi feladat beadása az aláírás megszerzésének és egyben a vizsgára bocsájtásnak szükséges feltétele. A jegy beírásának feltétele, hogy az elfogadott házi feladat kódja a tárgy honlapjára fel legyen töltve (e-mailben nem küldhető)! Vigyázat: a tárgy honlapján megjelenő feltöltési határidő nem azonos a beadási határidővel! A beadási határidőt a bemutatási időpontokkal együtt a tárgy hírei között szoktuk feltüntetni!
Vizsga a vizsgaidőszakban, melynek anyagát az előadáson és a gyakorlatokon elhangzottak képezik, azonban kiemelkedően jó házi feladat határidőre történő leadása esetén megajánlott jegy leheséges.

### Megajánlott jegy
Teljeskörűen működő és igényesen elkészített házi feladatra megajánlott jegy kapható, ha a hallgató legfeljebb 4 előadásról és 4 gyakorlatról hiányzott. A megajánlott jegy csak jó (4) vagy jeles (5) osztályzat lehet, amit a nagyházi feladat alapján állapítunk meg. A specifikáció leadása után a hallgatók visszajelzést kapnak, hogy a házi feladatuk esélyes-e a megajánlott jegyre. Ilyenkor még van lehetőség bővíteni a funkciókat, hogy megajánlott jegyet szerezhessenek.

Fontos: aki megajánlott jegyet szerzett, az is jelentkezzen a Neptunon vizsgára, mert a Neptunban megszűnt a megajánlott jegy fogalma!

### Önálló laboron is ASP.NET Core-ral szeretnék foglalkozni. Felvehetem-e ezt a tárgyat is mellé?
Az önálló labor és a választható tárgyak nem tudják egymást kizárni. Ezért egy optimális választás lehet, hogy a webportálok tárgy mellé egy ASP.NET Core-ral foglalkozó önálló labor témát választasz. Ebben az esetben megfelelően komplex alkalmazás készítése esetén ugyanaz az alkalmazás beadható mindkét tárgyhoz, csak meg kell jelölni, hogy mely részek melyik tárgyhoz készültek. Ennek részleteit Gincsai Gáborral tudod egyeztetni.