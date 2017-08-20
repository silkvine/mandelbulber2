/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * spherical fold CHS Cylinder Half Size. Darkbeam s code from M3D
 * @reference
 * http://www.fractalforums.com/mandelbulb-3d/custom-formulas-and-transforms-release-t17106/
 * This formula contains aux.color
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#include "cl_kernel_include_headers.h"

REAL4 TransfSphericalFoldCHSIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL tempZ = fabs(z.z) - fractal->transformCommon.offset05;
	REAL rr;
	if (aux->i >= fractal->transformCommon.startIterations
			&& aux->i < fractal->transformCommon.stopIterations)
	{
		rr = mad(z.x, z.x, z.y * z.y);
		if (tempZ > 0.0f) rr = rr + (tempZ * tempZ * fractal->transformCommon.scale1);
	}
	else
	{
		rr = dot(z, z);
	}

	z += fractal->mandelbox.offset;
	z *= fractal->transformCommon.scale;
	aux->DE = mad(aux->DE, fabs(fractal->transformCommon.scale), 1.0f);

	// Spherical Fold
	if (rr < fractal->transformCommon.minR2p25)
	{
		z *= fractal->transformCommon.maxMinR2factor;
		aux->DE *= fractal->transformCommon.maxMinR2factor;
		aux->color += fractal->mandelbox.color.factorSp1;
	}
	else if (rr < fractal->transformCommon.maxR2d1)
	{
		REAL tglad_factor2 = native_divide(fractal->transformCommon.maxR2d1, rr);
		z *= tglad_factor2;
		aux->DE *= tglad_factor2;
		aux->color += fractal->mandelbox.color.factorSp2;
	}
	z -= fractal->mandelbox.offset;
	return z;
}