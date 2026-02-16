INSERT INTO dbo.Category
( DisplayName, ParentCategoryId )
VALUES

( N'Írószerek', NULL ),
( N'Papír', NULL ),
( N'Iratrendezés', NULL ),
( N'Irodatechnika', NULL ),
( N'Nyomtató kellékek', NULL ),

-- Írószerek
( N'Ceruza', 1 ),
( N'Toll', 1 ),
( N'Filcek', 1 ),

-- Papíráru
( N'Fax papír', 2 ),
( N'Névjegykártya', 2 ),
( N'Fotópapír', 2 ),
( N'Boríték', 2 ),
( N'Nyomtatványok', 2 ),
( N'Füzet', 2 ),

-- Iratrendezés
( N'Mappák', 3 ),
( N'Irattárca', 3 ),
( N'Névjegytartók', 3 ),

-- Irodatechnika
( N'Számológép', 4 ),
( N'Bankjegyvizsgáló', 4 ),
( N'Iratmegsemmisítõ', 4 ),
( N'Laminálógép', 4 ),

-- Nyomtató kellékek
( N'Tonerek', 5 ),
( N'Tintapatronok', 5 ),
( N'Festékhenger', 5 )


INSERT INTO Product
(DisplayName, Price, CreatedDate, CategoryId )
VALUES
(N'Grafitceruza radírral, HB, hatszögletû, VICTORIA "100"', 100, GETDATE(), 6 ),
(N'Grafitceruza radírral, HB, hatszögletû, KORES', 3390, GETDATE(), 6 ),
(N'Grafitceruza, H, hatszögletû, KOH-I-NOOR "1770"', 48, GETDATE(), 6 ),

(N'Golyóstoll, 0,7 mm, kupakos, VICTORIA, kék', 740, GETDATE(), 7 ),
(N'Golyóstoll, 0,5 mm, kupakos, SCHNEIDER "Tops 505 M", zöld', 65, GETDATE(), 7 ),
(N'Golyóstoll, 0,7 mm, kupakos, kétvégû, ICO "Twins", kék-piros', 3150, GETDATE(), 7 ),

(N'Filctoll készlet, 1-5 mm, kimosható, MAPED "Color`Peps", 12 különbözõ szín', 957, GETDATE(), 8 ),
(N'Filctoll készlet, 2,8 mm, elhagyhatatlan kupakos, MAPED "Color`Peps Jungle", 12 különbözõ szín', 1425, GETDATE(), 8 ),

(N'Q1338A Lézertoner LaserJet 4200 nyomtatóhoz, HP fekete, 12k', 44920, GETDATE(), 22 ),
(N'Q2613A Lézertoner LaserJet 1300 nyomtatóhoz, HP fekete, 2,5k', 24003, GETDATE(), 22 ),
(N'Q2673A Lézertoner ColorLaserJet 3500, 3550 nyomtatókhoz, HP 309A vörös, 4k', 38404, GETDATE(), 22 ),

(N'51645AE Tintapatron DeskJet 710c, 720c, 815c nyomtatókhoz, HP 45 fekete, 42ml', 9080, GETDATE(), 23 ),
(N'C4810A Tintapatron fej DesignJet 500, 800 nyomtatókhoz, HP 11 fekete', 10260, GETDATE(), 23 ),
(N'C6656AE Tintapatron DeskJet 450c, 450cb, 5150 nyomtatókhoz, HP 56 fekete, 19ml', 6172, GETDATE(), 23 )


