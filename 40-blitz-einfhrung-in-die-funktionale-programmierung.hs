module Intro where


-- Ein Haustier ist eins der folgenden:
-- - Hund -ODER-
-- - Katze -ODER-
-- - Schlange
-- Fallunterscheidung
data Pet -- neuer Datentyp
    = Dog -- Fall
    | Cat
    | Snake
    deriving Show

-- Ist ein Haustier niedlich?
isCute :: Pet -> Bool
isCute Dog = True
isCute Cat = True
isCute Snake = False

-- Tier (auf dem texanischen Highway) ist eins der folgenden:
-- - Gürteltier -ODER-
-- - Papagei

-- Ein Gürteltier hat folgende Eigenschaften:
-- - (tot -ODER- lebendig) -UND-
-- - Gewicht
-- zusammengesetzte Daten

-- Papagei hat folgende Eigenschafen:
-- - Satz -UND-
-- - Gewicht

data Liveness
    = Dead 
    | Alive
    deriving Show

type Weight = Double

data Animal
    = Dillo { dilloLiveness :: Liveness, dilloWeight :: Weight  } -- "Record"
    | Parrot { parrotSentence :: String, parrotWeight :: Weight }
    deriving Show

dillo1 = Dillo { dilloLiveness = Alive, dilloWeight = 10 }
dillo2 = Dillo { dilloLiveness = Dead, dilloWeight = 8}
parrot1 = Parrot { parrotSentence = "Hallo Tuebix", parrotWeight = 1 }

runOver :: Animal -> Animal
runOver (Dillo { dilloWeight = w }) =
    Dillo { dilloLiveness = Dead, dilloWeight = w }
runOver (Parrot { parrotSentence = s, parrotWeight = w }) =
    Parrot { parrotSentence = "", parrotWeight = w }


{-
interface Animal {
    void runOver()
}
class Dillo implements Animal {
  Liveness liveness;
  Weight weight;

   void runOver() { 
    self.liveness = Dead;
  }
}

class Parrot implements Animal {

} 
-}

-- Effekte
-- - I/O
-- - Zustand
-- - Exceptions

-- I/O-behafteter Ablauf mit Ergebnis a: IO a
-- main :: IO ()

-- Kombinatormodelle


-- Seife
-- Shampoo
-- Duschgel, bestehend aus Seife und Shampoo

data Hairtype = Normal | Oily | Dandruff
  deriving (Show)

data ShowerProduct =
    Soap { soapPh :: Double }
  | Shampoo { shampooHairtype :: Hairtype }
  | ShowerGel ShowerProduct ShowerProduct -- Kombinator
--            ^^^^^^^^^^^^^ Selbstreferenz
  deriving Show

soap1 = Soap { soapPh = 7 }
shampoo1 = Shampoo { shampooHairtype = Oily }
showergel1 = ShowerGel soap1 shampoo1
showergel2 = ShowerGel showergel1 soap1

soapProportion :: ShowerProduct -> Double -- zwischen 0 und 1
soapProportion (Soap {}) = 1
soapProportion (Shampoo {}) = 0 
soapProportion (ShowerGel product1 product2) =
    (soapProportion product1 + soapProportion product2) / 2

{-
- einfaches Beispiel
Zero-Coupon Bond
"Ich bekomme 24.12. 100€."

- "atomare Bestandteile / Ideen" zerlegen
  - Währung
  - Betrag
  - Datum / später

- Wiederholen

FX Swap:
- Weihnachten bekomme ich 100€ und zahle $100.
-}

data Date = Date String
  deriving Show
type Amount = Double
data Currency = EUR | GBP | USD
  deriving Show
{-
data Contract =
    ZeroCouponBond Date Amount Currency
    deriving Show

zcb1 = ZeroCouponBond (Date "2023-12-24") 100 EUR
-}

data Contract =
    -- "1€ jetzt"
    One Currency
    -- "100€ jetzt"
  | Multiple Amount Contract
  | Delay Date Contract
  | Invert Contract
  | And Contract Contract
  | Zero
  deriving Show

c1 = One EUR
-- 100€ jetzt
c2 = Multiple 100 (One EUR)

zcb1 = Delay (Date "2023-12-14") (Multiple 100 (One EUR))

zeroCouponBond date amount currency =
    Delay date (Multiple amount (One currency))

zcb1' = zeroCouponBond (Date "2023-12-24") 100 EUR
