/*******************************************************************************
 * Copyright (c) 2000, 2005 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     IBM Corporation - initial API and implementation
 * Port to the D programming language:
 *     Frank Benoit <benoit@tionex.de>
 *******************************************************************************/
module org.eclipse.swt.internal.Lock;

import java.lang.all;
import java.lang.Thread;
version(Tango){
    import tango.core.sync.Mutex;
    import tango.core.sync.Condition;
} else { // Phobos
}

/**
 * Instance of this represent a recursive monitor.
 */
public class Lock {
    int count, waitCount;
    Thread owner;
    version(Tango){
        Mutex mutex;
        Condition cond;
    } else { // Phobos
    }


    public this() {
        version(Tango){
            mutex = new Mutex;
            cond = new Condition(mutex);
        } else { // Phobos
        }
    }
    /**
     * Locks the monitor and returns the lock count. If
     * the lock is owned by another thread, wait until
     * the lock is released.
     *
     * @return the lock count
     */
    public int lock() {
        version(Tango){
            synchronized (mutex) {
                Thread current = Thread.currentThread();
                if (owner !is current) {
                    waitCount++;
                    while (count > 0) {
                        try {
                            cond.wait();
                        } catch (SyncException e) {
                            /* Wait forever, just like synchronized blocks */
                        }
                    }
                    --waitCount;
                    owner = current;
                }
                return ++count;
            }
        } else { // Phobos
            implMissing( __FILE__, __LINE__ );
            return 0;
        }
    }

    /**
     * Unlocks the monitor. If the current thread is not
     * the monitor owner, do nothing.
     */
    public void unlock() {
        version(Tango){
            synchronized (mutex) {
                Thread current = Thread.currentThread();
                if (owner is current) {
                    if (--count is 0) {
                        owner = null;
                        if (waitCount > 0) cond.notifyAll();
                    }
                }
            }
        } else { // Phobos
            implMissing( __FILE__, __LINE__ );
        }
    }
}
