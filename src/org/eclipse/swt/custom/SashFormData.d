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
module org.eclipse.swt.custom.SashFormData;

import java.lang.all;

static import tango.text.Util;
import tango.util.Convert;

class SashFormData {

    long weight;

String getName () {
    String string = this.classinfo.name;
    int index = tango.text.Util.locatePrior( string ,'.' );
    if (index is string.length ) return string;
    return string[ index + 1 .. $ ];
}

/**
 * Returns a string containing a concise, human-readable
 * description of the receiver.
 *
 * @return a string representation of the event
 */
public override String toString () {
    return getName()~" {weight="~to!(String)(weight)~"}"; //$NON-NLS-2$
}
}
