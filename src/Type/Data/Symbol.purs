module Type.Data.Symbol
  ( module Data.Symbol
  , class CompareSymbol
  , compareSymbol
  , class AppendSymbol
  , appendSymbol
  , class Equals
  , equals
  , class ConsSymbol
  , unconsSymbol
  ) where

import Data.Symbol (SProxy(..), class IsSymbol, reflectSymbol, reifySymbol)
import Type.Data.Ordering (OProxy(..), kind Ordering, EQ)
import Type.Data.Ordering (class Equals) as Ordering
import Type.Data.Boolean (kind Boolean, BProxy(..))

-- | Compare two `Symbol` types
class CompareSymbol (lhs :: Symbol)
                    (rhs :: Symbol)
                    (out :: Ordering) |
                    lhs rhs -> out

compareSymbol :: forall l r o. CompareSymbol l r o => SProxy l -> SProxy r -> OProxy o
compareSymbol _ _ = OProxy


-- | Append two `Symbol` types together
class AppendSymbol (lhs :: Symbol)
                   (rhs :: Symbol)
                   (out :: Symbol) |
                   lhs rhs -> out

appendSymbol :: forall l r o. AppendSymbol l r o => SProxy l -> SProxy r -> SProxy o
appendSymbol _ _ = SProxy

class ConsSymbol (head :: Symbol)
                 (tail :: Symbol)
                 (sym :: Symbol) |
                 sym -> head tail, head tail -> sym

unconsSymbol :: forall h t s. ConsSymbol h t s => SProxy s -> {head :: SProxy h, tail :: SProxy t}
unconsSymbol _ = {head : SProxy, tail : SProxy}

class Equals (lhs :: Symbol)
             (rhs :: Symbol)
             (out :: Boolean) |
             lhs rhs -> out

instance equalsSymbol
  :: (CompareSymbol lhs rhs ord,
      Ordering.Equals EQ ord out)
  => Equals lhs rhs out

equals :: forall l r o. Equals l r o => SProxy l -> SProxy r -> BProxy o
equals _ _ = BProxy

