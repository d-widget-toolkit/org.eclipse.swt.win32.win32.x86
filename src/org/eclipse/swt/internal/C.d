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
module org.eclipse.swt.internal.C;

import org.eclipse.swt.internal.Platform;

static import tango.stdc.string;

public class C : Platform {
    alias tango.stdc.string.memmove MoveMemory;
//public static final native void free (int /*long*/ ptr);
//public static final native int /*long*/ getenv (byte[] wcsToMbcs);
//public static final native int /*long*/ malloc (int /*long*/ size);
}
