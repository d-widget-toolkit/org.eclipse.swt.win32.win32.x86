/*******************************************************************************
 * Copyright (c) 2000, 2007 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     IBM Corporation - initial API and implementation
 *******************************************************************************/
module org.eclipse.swt.internal.LONG;

import java.lang.all;

public class LONG {
    public int /*long*/ value;
    
    public this (int /*long*/ value) {
        this.value = value;
    }

    public equals_t opEquals (Object object) {
        if (object is this) return true;
        if( auto obj = cast(LONG)object ){
            return obj.value is this.value;
        }
        return false;
    }

    public int hashCode () {
        return cast(int)/*64*/value;
    }
}
