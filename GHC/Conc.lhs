\begin{code}
{-# OPTIONS_GHC -XNoImplicitPrelude #-}
{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
{-# OPTIONS_HADDOCK not-home #-}
-----------------------------------------------------------------------------
-- |
-- Module      :  GHC.Conc
-- Copyright   :  (c) The University of Glasgow, 1994-2002
-- License     :  see libraries/base/LICENSE
-- 
-- Maintainer  :  cvs-ghc@haskell.org
-- Stability   :  internal
-- Portability :  non-portable (GHC extensions)
--
-- Basic concurrency stuff.
-- 
-----------------------------------------------------------------------------

-- No: #hide, because bits of this module are exposed by the stm package.
-- However, we don't want this module to be the home location for the
-- bits it exports, we'd rather have Control.Concurrent and the other
-- higher level modules be the home.  Hence:

#include "Typeable.h"

-- #not-home
module GHC.Conc
        ( ThreadId(..)

        -- * Forking and suchlike
        , forkIO        -- :: IO a -> IO ThreadId
        , forkIOUnmasked
        , forkOnIO      -- :: Int -> IO a -> IO ThreadId
        , forkOnIOUnmasked
        , numCapabilities -- :: Int
        , numSparks       -- :: IO Int
        , childHandler  -- :: Exception -> IO ()
        , myThreadId    -- :: IO ThreadId
        , killThread    -- :: ThreadId -> IO ()
        , throwTo       -- :: ThreadId -> Exception -> IO ()
        , par           -- :: a -> b -> b
        , pseq          -- :: a -> b -> b
        , runSparks
        , yield         -- :: IO ()
        , labelThread   -- :: ThreadId -> String -> IO ()

        , ThreadStatus(..), BlockReason(..)
        , threadStatus  -- :: ThreadId -> IO ThreadStatus

        -- * Waiting
        , threadDelay           -- :: Int -> IO ()
        , registerDelay         -- :: Int -> IO (TVar Bool)
        , threadWaitRead        -- :: Int -> IO ()
        , threadWaitWrite       -- :: Int -> IO ()

        -- * TVars
        , STM(..)
        , atomically    -- :: STM a -> IO a
        , retry         -- :: STM a
        , orElse        -- :: STM a -> STM a -> STM a
        , catchSTM      -- :: STM a -> (Exception -> STM a) -> STM a
        , alwaysSucceeds -- :: STM a -> STM ()
        , always        -- :: STM Bool -> STM ()
        , TVar(..)
        , newTVar       -- :: a -> STM (TVar a)
        , newTVarIO     -- :: a -> STM (TVar a)
        , readTVar      -- :: TVar a -> STM a
        , readTVarIO    -- :: TVar a -> IO a
        , writeTVar     -- :: a -> TVar a -> STM ()
        , unsafeIOToSTM -- :: IO a -> STM a

        -- * Miscellaneous
        , withMVar
#ifdef mingw32_HOST_OS
        , asyncRead     -- :: Int -> Int -> Int -> Ptr a -> IO (Int, Int)
        , asyncWrite    -- :: Int -> Int -> Int -> Ptr a -> IO (Int, Int)
        , asyncDoProc   -- :: FunPtr (Ptr a -> IO Int) -> Ptr a -> IO Int

        , asyncReadBA   -- :: Int -> Int -> Int -> Int -> MutableByteArray# RealWorld -> IO (Int, Int)
        , asyncWriteBA  -- :: Int -> Int -> Int -> Int -> MutableByteArray# RealWorld -> IO (Int, Int)
#endif

#ifndef mingw32_HOST_OS
        , Signal, HandlerFun, setHandler, runHandlers
#endif

        , ensureIOManagerIsRunning

#ifdef mingw32_HOST_OS
        , ConsoleEvent(..)
        , win32ConsoleHandler
        , toWin32ConsoleEvent
#endif
        , setUncaughtExceptionHandler      -- :: (Exception -> IO ()) -> IO ()
        , getUncaughtExceptionHandler      -- :: IO (Exception -> IO ())

        , reportError, reportStackOverflow
        ) where

import GHC.Conc.IO
import GHC.Conc.Sync

#ifndef mingw32_HOST_OS
import GHC.Conc.Signal
#endif

\end{code}
