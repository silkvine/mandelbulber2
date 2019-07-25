/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2019 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * mix integer powers 1234

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "MandelbulbPower1234Iteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 MandelbulbPower1234Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 c = aux->const_c;
	if (fractal->transformCommon.functionEnabledFalse)
	{
		if (fractal->transformCommon.functionEnabledAxFalse
				&& aux->i >= fractal->transformCommon.startIterationsX
				&& aux->i < fractal->transformCommon.stopIterationsX)
			z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledAyFalse
				&& aux->i >= fractal->transformCommon.startIterationsY
				&& aux->i < fractal->transformCommon.stopIterationsY)
			z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledAzFalse
				&& aux->i >= fractal->transformCommon.startIterationsZ
				&& aux->i < fractal->transformCommon.stopIterationsZ)
			z.z = fabs(z.z);
	}
	REAL r = aux->r;
	REAL de1 = 0.0f;
	REAL de2 = 0.0f;
	REAL de3 = 0.0f;
	REAL de4 = 0.0f;
	REAL4 zer0s = (REAL4){0.0f, 0.0f, 0.0f, 0.0f};
	REAL4 newZ1 = zer0s;
	REAL4 newZ2 = zer0s;
	REAL4 newZ3 = zer0s;
	REAL4 newZ4 = zer0s;

	REAL th0 = fractal->bulb.betaAngleOffset;
	REAL ph0 = fractal->bulb.alphaAngleOffset;

	if (!fractal->transformCommon.functionEnabledxFalse)
	{
		th0 += asin(native_divide(z.z, r));
		ph0 += atan2(z.y, z.x);
	}
	else
	{
		th0 += acos(native_divide(z.z, r));
		ph0 += atan(native_divide(z.y, z.x));
	}

	REAL4 w8ts = fractal->transformCommon.offset1111;
	REAL rp = r;

	if (fractal->transformCommon.functionEnabledx) // 0ne
	{
		newZ1 = z * w8ts.x;
		de1 = w8ts.x;
	}

	if (fractal->transformCommon.functionEnabledy) // two
	{
		de2 = (mad(rp * aux->DE, 2.0f, 1.0f)) * w8ts.y;
		rp *= r;
		REAL th = th0 * 2.0f * fractal->transformCommon.scaleA1;
		REAL ph = ph0 * 2.0f * fractal->transformCommon.scaleB1;

		if (!fractal->transformCommon.functionEnabledxFalse)
		{
			REAL costh = native_cos(th);
			newZ2 = rp * (REAL4){costh * native_cos(ph), native_sin(ph) * costh, native_sin(th), 0.0f};
		}
		else
		{
			REAL sinth = native_sin(th);
			newZ2 = rp * (REAL4){sinth * native_sin(ph), native_cos(ph) * sinth, native_cos(th), 0.0f};
		}
		newZ2 *= w8ts.y;
	}

	if (fractal->transformCommon.functionEnabledz) // three
	{
		rp = r * r;
		de3 = (mad(rp * aux->DE, 3.0f, 1.0f)) * w8ts.z;
		rp *= r;
		REAL th = th0 * 3.0f * fractal->transformCommon.scaleA1;
		REAL ph = ph0 * 3.0f * fractal->transformCommon.scaleB1;

		if (!fractal->transformCommon.functionEnabledxFalse)
		{
			REAL costh = native_cos(th);
			newZ3 = rp * (REAL4){costh * native_cos(ph), native_sin(ph) * costh, native_sin(th), 0.0f};
		}
		else
		{
			REAL sinth = native_sin(th);
			newZ3 = rp * (REAL4){sinth * native_sin(ph), native_cos(ph) * sinth, native_cos(th), 0.0f};
		}
		newZ3 *= w8ts.z;
	}

	if (fractal->transformCommon.functionEnabledw) // four
	{
		rp = r * r * r;
		de4 = (mad(rp * aux->DE, 4.0f, 1.0f)) * w8ts.w;
		rp *= r;
		REAL th = th0 * 4.0f * fractal->transformCommon.scaleA1;
		REAL ph = ph0 * 4.0f * fractal->transformCommon.scaleB1;

		if (!fractal->transformCommon.functionEnabledxFalse)
		{
			REAL costh = native_cos(th);
			newZ4 = rp * (REAL4){costh * native_cos(ph), native_sin(ph) * costh, native_sin(th), 0.0f};
		}
		else
		{
			REAL sinth = native_sin(th);
			newZ4 = rp * (REAL4){sinth * native_sin(ph), native_cos(ph) * sinth, native_cos(th), 0.0f};
		}
		newZ4 *= w8ts.w;
	}
	z = newZ1 + newZ2 + newZ3 + newZ4;
	aux->DE = fabs(de1 + de2 + de3 + de4);

	if (fractal->transformCommon.functionEnabledKFalse)
	{
		if (fractal->transformCommon.functionEnabledDFalse
				&& aux->i >= fractal->transformCommon.startIterationsD
				&& aux->i < fractal->transformCommon.stopIterationsD)
		{
			REAL temp = z.x;
			z.x = z.y;
			z.y = temp;
		}
		if (fractal->transformCommon.functionEnabledEFalse
				&& aux->i >= fractal->transformCommon.startIterationsE
				&& aux->i < fractal->transformCommon.stopIterationsE)
		{
			REAL temp = z.x;
			z.x = z.z;
			z.z = temp;
		}

		// swap
		if (fractal->transformCommon.functionEnabledBxFalse) z.x = -z.x;
		if (fractal->transformCommon.functionEnabledByFalse) z.y = -z.y;
		if (fractal->transformCommon.functionEnabledBzFalse) z.z = -z.z;
	}

	z += fractal->transformCommon.additionConstant000;

	if (fractal->transformCommon.addCpixelEnabledFalse)
	{
		REAL4 tempC = c;
		if (fractal->transformCommon.alternateEnabledFalse) // alternate
		{
			tempC = aux->c;
			switch (fractal->mandelbulbMulti.orderOfXYZC)
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
			switch (fractal->mandelbulbMulti.orderOfXYZC)
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
		z += tempC * fractal->transformCommon.constantMultiplierC111;
	}
	// rotation
	if (fractal->transformCommon.functionEnabledRFalse
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
	{
		z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
	}
	if (fractal->analyticDE.enabledFalse)
		aux->DE = mad(aux->DE, fractal->analyticDE.scale1, fractal->analyticDE.offset0);
	return z;
}