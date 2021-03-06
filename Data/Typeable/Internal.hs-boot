{-# LANGUAGE Unsafe #-}
{-# LANGUAGE CPP, NoImplicitPrelude, MagicHash, PolyKinds #-}

module Data.Typeable.Internal (
    Proxy(..),
    Typeable(typeRep),
    TypeRep,
    TyCon,
    mkTyCon,
    mkTyConApp
  ) where

import GHC.Base

data TypeRep
data TyCon

#include "MachDeps.h"

#if WORD_SIZE_IN_BITS < 64
mkTyCon :: Word64# -> Word64# -> String -> String -> String -> TyCon
#else
mkTyCon :: Word#   -> Word#   -> String -> String -> String -> TyCon
#endif

mkTyConApp   :: TyCon -> [TypeRep] -> TypeRep

data Proxy t = Proxy

class Typeable a where
  typeRep :: proxy a -> TypeRep
