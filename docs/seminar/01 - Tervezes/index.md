# Tervezés

## Specifikáció

- **Könyvek böngészése**
A könyveket kategóriákba kell tundni szervezni (több szintű). Egy kategóriát kiválasztva megjelennek a kategóriában lévő könyvek a legfontosabb információkkal (cím, szerző, ár, borítókép) egy lapozható listában.
Az alkalmazás kezdő oldala is egy ilyen listát tartalmaz, azonban az a kategóriákban kiemelt / újdonságokat mutatja. Ha itt egy könyvre kattintunk, akkor bejön a könyv részletes oldala, amiben minden adat megtalálható a könyvről, illetve a hozzá tartozó ajánlók és kommentek is.

- **Könyvek keresése**
A felhasználók több esetben konkrét könyvet keresnek, aminek ismerik a címét vagy annak egy részét. Ehhez szükséges egy kereső megvalósítása, ami felajánlja gépelés közben a találatokat, és ha egy konkrét könyvre kattintunk, elvisz annak a részletes oldalára. Ha pedig több találat lenne, akkor egy részletes keresést indít, ahol a listázzuk a találatokat egy külön oldalon.

- **Kosár és megrendelés**
A felhasználók a megvenni kívánt könyveket egy kosárba gyűjthetnek, majd a későbbiekben ezt feladhatják, mint egy rendelést. A korábbi rendelések listáját később visszanézhetik és nyomon követhetik azok állapotát.

- **Felhasználó kezelés**
Szükséges, hogy a felhasználók tudjanak regisztrálni és belépni. A belépést akár külső autentikációs szolgáltatással is lehessen megvalósítani (pl: Google, Facebook accounttal)
Ezen felül szükséges megkülönböztetni az admin felhasználókat, akik szerkeszthetik a könyvek és a kategóriák adatait, illetve moderálhatják a közösség által készített tartalmakat.

- **Profil adatok kezelése**
Lehetőséget kell adni a jelszóváltoztatásra, illetve a felhasználónak a szállítási és számlázási adatait el kell tárolni.

- **Ajánlók létrehozása adott könyvhöz**
A felhasználók egy-egy könyvhöz ajánlókat hozhatnak létre, melyek a könyv részletes oldalán megjelennek egy listában. Az ajánlók rendelkeznek részletes oldallal is, és egy külön oldalon elérhetők a legújabb idézetek is.

- **Kommentek fűzése a könyvekhez**
A felhasználók egy-egy könyvhöz egyszerű kommentet is lehet fűzni, ami megjelenik a könyv részletes oldalon.

## UI terv készítése

### Balsamiq

A tervezés legfontosabb része, hogy azt tervezzük meg, amit a megrendelő szeretne. Ehhez érdemes a fejlesztés legelején gyorsan megtervezni a legfontosabb wireframeeket.
Ehhez egy kiváló eszköz a [Balsamiq](http://www.balsamiq.com), melynek webes verziója regisztráció után 14 napig ingyenesen használható.

TODO: Leírás a balsamiqhoz. Hogyan lesz trial fiók hozzá.

### Figma

TODO: Leírás + rajzok

## Adatbázis tervezés

TODO: Kép beillesztése
TODO: Projektbe kerüljön be a class diagram is a modellről.