module Type.Data.Nat
  ( module Data.Nat
  , class AddNat
  , add
  , subtract
  ) where

import Data.Nat (NProxy(..), class IsNat, reflectNat, reifyNat)

class AddNat (a :: Nat) (b :: Nat) (c :: Nat) | a b -> c, a c -> b, c b -> a

add :: forall a b c. AddNat a b c => NProxy a -> NProxy b -> NProxy c
add _ _ = NProxy

subtract :: forall a b c. AddNat a b c => NProxy c -> NProxy b -> NProxy a
subtract _ _ = NProxy
