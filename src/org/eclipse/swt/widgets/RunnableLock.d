/*******************************************************************************
 * Copyright (c) 2000, 2007 IBM Corporation and others.
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
module org.eclipse.swt.widgets.RunnableLock;

import java.lang.all;
import java.lang.Thread;
version(Tango){
    import tango.core.sync.Condition;
    import tango.core.sync.Mutex;
} else { // Phobos
    alias Object Mutex; //FIXME, this is just a dummy because of Mutex missing
}

/**
 * Instances of this class are used to ensure that an
 * application cannot interfere with the locking mechanism
 * used to implement asynchronous and synchronous communication
 * between widgets and background threads.
 */

class RunnableLock : Mutex {
    Runnable runnable;
    Thread thread;
    Exception throwable;
    version(Tango){
        Condition cond;
    } else { // Phobos
    }

    this (Runnable runnable) {
        this.runnable = runnable;
        version(Tango){
            this.cond = new Condition(this);
        } else { // Phobos
            implMissing( __FILE__, __LINE__ );
        }
    }

    bool done () {
        return runnable is null || throwable !is null;
    }

    void run () {
        if (runnable !is null) runnable.run ();
        runnable = null;
    }

    void notifyAll(){
        version(Tango){
            cond.notifyAll();
        } else { // Phobos
            implMissing( __FILE__, __LINE__ );
        }
    }
    void wait(){
        version(Tango){
            cond.wait();
        } else { // Phobos
            implMissing( __FILE__, __LINE__ );
        }
    }

}
