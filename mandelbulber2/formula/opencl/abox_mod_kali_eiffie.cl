/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * ABoxModKaliEiffie, modified formula from Mandelbulb3D
 * @reference http://www.fractalforums.com/new-theories-and-research/aboxmodkali-the-2d-version/
 * This formula contains aux.color
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#include "cl_kernel_include_headers.h"

REAL4 AboxModKaliEiffieIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 c = aux->const_c;
	REAL4 oldZ = z;
	z.x = fabs(z.x + fractal->transformCommon.additionConstant111.x)
				- fabs(z.x - fractal->transformCommon.additionConstant111.x) - z.x;
	z.y = fabs(z.y + fractal->transformCommon.additionConstant111.y)
				- fabs(z.y - fractal->transformCommon.additionConstant111.y) - z.y;
	z.z = fabs(z.z + fractal->transformCommon.additionConstant111.z)
				- fabs(z.z - fractal->transformCommon.additionConstant111.z) - z.z;

	if (z.x != oldZ.x) aux->color += fractal->mandelbox.color.factor.x;
	if (z.y != oldZ.y) aux->color += fractal->mandelbox.color.factor.y;
	if (z.y != oldZ.z) aux->color += fractal->mandelbox.color.factor.z;

	if (fractal->transformCommon.functionEnabledxFalse
			&& aux->i >= fractal->transformCommon.startIterationsA
			&& aux->i < fractal->transformCommon.stopIterationsA) // box fold z.z
	{
		REAL zLimit = fractal->transformCommon.additionConstant111.z * fractal->transformCommon.scale1;
		REAL zValue = fractal->mandelbox.foldingValue * fractal->transformCommon.scale1;
		if (fabs(z.z) > zLimit)
		{
			z.z = mad(sign(z.z), zValue, -z.z);
			aux->color += fractal->mandelbox.color.factor.z;
		}
	}

	if (fractal->transformCommon.functionEnabled)
	{
		z = (REAL4){z.z, z.y, z.x, z.w}; // swap
	}
	if (z.y > z.x) z = (REAL4){z.y, z.x, z.z, z.w}; // conditional

	REAL rr = dot(z, z);
	REAL MinR = fractal->transformCommon.minR05;
	REAL m = fractal->transformCommon.scale015;
	if (rr < MinR)
	{
		m = native_divide(m, MinR);
		aux->color += fractal->mandelbox.color.factorSp1;
	}
	else
	{
		if (rr < 1.0f)
		{
			m = native_divide(m, rr);
			aux->color += fractal->mandelbox.color.factorSp2;
		}
	}
	z = z * m;

	z += fractal->transformCommon.additionConstant000;

	if (fractal->transformCommon.addCpixelEnabledFalse)
	{
		REAL4 tempC = c;
		if (fractal->transformCommon.alternateEnabledFalse) // alternate
		{
			tempC = aux->c;
			switch (fractal->mandelbulbMulti.orderOfXYZ)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (REAL4){tempC.x, tempC.y, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (REAL4){tempC.x, tempC.z, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (REAL4){tempC.y, tempC.x, tempC.z, tempC.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (REAL4){tempC.y, tempC.z, tempC.x, tempC.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (REAL4){tempC.z, tempC.x, tempC.y, tempC.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (REAL4){tempC.z, tempC.y, tempC.x, tempC.w}; break;
			}
			aux->c = tempC;
		}
		else
		{
			switch (fractal->mandelbulbMulti.orderOfXYZ)
			{
				case multi_OrderOfXYZCl_xyz:
				default: tempC = (REAL4){c.x, c.y, c.z, c.w}; break;
				case multi_OrderOfXYZCl_xzy: tempC = (REAL4){c.x, c.z, c.y, c.w}; break;
				case multi_OrderOfXYZCl_yxz: tempC = (REAL4){c.y, c.x, c.z, c.w}; break;
				case multi_OrderOfXYZCl_yzx: tempC = (REAL4){c.y, c.z, c.x, c.w}; break;
				case multi_OrderOfXYZCl_zxy: tempC = (REAL4){c.z, c.x, c.y, c.w}; break;
				case multi_OrderOfXYZCl_zyx: tempC = (REAL4){c.z, c.y, c.x, c.w}; break;
			}
		}
		z += tempC * fractal->transformCommon.constantMultiplier111;
	}
	if (fractal->transformCommon.rotationEnabled && aux->i >= fractal->transformCommon.startIterations
			&& aux->i < fractal->transformCommon.stopIterations)
	{
		z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
	}
	aux->DE = mad(aux->DE, fabs(m), 1.0f);

	aux->foldFactor = fractal->foldColor.compFold0; // fold group weight
	aux->minRFactor = fractal->foldColor.compMinR;	// orbit trap weight

	REAL scaleColor = fractal->foldColor.colorMin + fabs(m); // scale, useScale, m, etc
	// scaleColor += fabs(fractal->mandelbox.scale);
	aux->scaleFactor = scaleColor * fractal->foldColor.compScale;
	return z;
}