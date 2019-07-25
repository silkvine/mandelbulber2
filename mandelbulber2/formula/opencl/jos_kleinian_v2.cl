/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2019 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * JosLeys-Kleinian V2 formula
 * @reference
 *
 http://www.fractalforums.com/3d-fractal-generation/an-escape-tim-algorithm-for-kleinian-group-limit-sets/msg98248/#msg98248
 * This formula contains aux.color and aux.DE

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "JosKleinianV2Iteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 JosKleinianV2Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	// sphere inversion
	if (fractal->transformCommon.sphereInversionEnabledFalse
			&& aux->i >= fractal->transformCommon.startIterationsD
			&& aux->i < fractal->transformCommon.stopIterationsD1)
	{
		REAL rr = 1.0f;
		z += fractal->transformCommon.offset000;
		rr = dot(z, z);
		z *= native_divide(fractal->transformCommon.maxR2d1, rr);
		z += fractal->transformCommon.additionConstant000 - fractal->transformCommon.offset000;
		z *= fractal->transformCommon.scaleA1;
		// REAL r = native_sqrt(rr);
		aux->DE *= (native_divide(fractal->transformCommon.maxR2d1, rr)) * fractal->analyticDE.scale1
							 * fractal->transformCommon.scaleA1;
	}

	if (fractal->transformCommon.functionEnabledCyFalse
			&& aux->i >= fractal->transformCommon.startIterationsC
			&& aux->i < fractal->transformCommon.stopIterationsC1)
	{
		REAL4 oldZ = z;
		REAL4 trigZ = (REAL4){0.0f, 0.0f, 0.0f, 0.0f};
		REAL4 scaleZ = z * fractal->transformCommon.constantMultiplierC111;

		if (fractal->transformCommon.functionEnabledAx)
		{
			if (!fractal->transformCommon.functionEnabledAxFalse)
				trigZ.x = native_sin(scaleZ.x);
			else
				trigZ.x = native_cos(scaleZ.x); // scale =0, cos = 1
		}
		if (fractal->transformCommon.functionEnabledAy)
		{
			if (!fractal->transformCommon.functionEnabledAyFalse)
				trigZ.y = native_sin(scaleZ.y);
			else
				trigZ.y = native_cos(scaleZ.y);
		}
		if (fractal->transformCommon.functionEnabledAz)
		{
			if (!fractal->transformCommon.functionEnabledAzFalse)
				trigZ.z = native_sin(scaleZ.z);
			else
				trigZ.z = native_cos(scaleZ.z);
		}

		z = trigZ * fractal->transformCommon.scale;
		if (fractal->transformCommon.functionEnabledFalse)
		{
			z.x = z.x * native_divide(fractal->transformCommon.scale, (fabs(oldZ.x) + 1.0f));
			z.y = z.y * native_divide(fractal->transformCommon.scale, (fabs(oldZ.y) + 1.0f));
			z.z = z.z * native_divide(fractal->transformCommon.scale, (fabs(oldZ.z) + 1.0f));
			// aux->DE = aux->DE * native_divide(length(z), length(oldZ));
		}
	}

	if (fractal->transformCommon.functionEnabledJFalse
			&& aux->i >= fractal->transformCommon.startIterationsA
			&& aux->i < fractal->transformCommon.stopIterationsA)
	{
		if (z.z > z.x)
		{
			REAL temp = z.x;
			z.x = z.z;
			z.z = temp;
		}
	}

	// kleinian
	if (aux->i >= fractal->transformCommon.startIterationsF
			&& aux->i < fractal->transformCommon.stopIterationsF)
	{
		REAL a = fractal->transformCommon.foldingValue;
		REAL b = fractal->transformCommon.offset;
		REAL c = fractal->transformCommon.offsetA0;
		REAL f = sign(b);

		// wrap
		REAL4 box_size = fractal->transformCommon.offset111;
		REAL3 box1 = (REAL3){2.0f * box_size.x, a * box_size.y, 2.0f * box_size.z};
		REAL3 box2 = (REAL3){-box_size.x, -box_size.y + 1.0f, -box_size.z};
		REAL3 wrapped = wrap(z.xyz, box1, box2);

		z = (REAL4){wrapped.x, wrapped.y, wrapped.z, z.w};
		/*{
			z.x += box_size.x;
			z.z += box_size.z;
			z.x = z.x - 2.0f * box_size.x * floor(native_divide(z.x, 2.0f) * box_size.x) - box_size.x;
			z.z = z.z - 2.0f * box_size.z * floor(native_divide(z.z, 2.0f) * box_size.z) - box_size.z;
			z.y += box_size.y - 1.0f;
			z.y = z.y - a * box_size.y * floor(native_divide(z.y, a) * box_size.y);
			z.y -= (box_size.y - 1.0f);
		}*/

		if (z.y
				>= a
						 * (0.5f
								 + 0.2f * native_sin(f * M_PI_F * native_divide((mad(b, 0.5f, z.x)), box_size.x))))
		{
			z.x = -z.x - b;
			z.y = -z.y + a;
			z.z = -z.z - c;
		}

		REAL rr = dot(z, z);

		REAL4 colorVector = (REAL4){z.x, z.y, z.z, rr};
		aux->color = min(aux->color, length(colorVector)); // For coloring

		REAL iR = native_recip(rr);
		z *= -iR; // invert and mirror
		z.x = -z.x - b;
		z.y = a + z.y;
		z.z = -z.z - c;

		aux->DE *= fabs(iR);
	}

	if (fractal->transformCommon.functionEnabledEFalse
			&& aux->i >= fractal->transformCommon.startIterationsE
			&& aux->i < fractal->transformCommon.stopIterationsE)
	{
		z.z = sign(z.z)
					* (fractal->transformCommon.offset1 - fabs(z.z)
							+ fabs(z.z) * fractal->transformCommon.scale0);
	}
	return z;
}