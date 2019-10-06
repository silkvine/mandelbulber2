/**
 * Mandelbulber v2, a 3D fractal generator       ,=#MKNmMMKmmßMNWy,
 *                                             ,B" ]L,,p%%%,,,§;, "K
 * Copyright (C) 2014-19 Mandelbulber Team     §R-==%w["'~5]m%=L.=~5N
 *                                        ,=mm=§M ]=4 yJKA"/-Nsaj  "Bw,==,,
 * This file is part of Mandelbulber.    §R.r= jw",M  Km .mM  FW ",§=ß., ,TN
 *                                     ,4R =%["w[N=7]J '"5=],""]]M,w,-; T=]M
 * Mandelbulber is free software:     §R.ß~-Q/M=,=5"v"]=Qf,'§"M= =,M.§ Rz]M"Kw
 * you can redistribute it and/or     §w "xDY.J ' -"m=====WeC=\ ""%""y=%"]"" §
 * modify it under the terms of the    "§M=M =D=4"N #"%==A%p M§ M6  R' #"=~.4M
 * GNU General Public License as        §W =, ][T"]C  §  § '§ e===~ U  !§[Z ]N
 * published by the                    4M",,Jm=,"=e~  §  §  j]]""N  BmM"py=ßM
 * Free Software Foundation,          ]§ T,M=& 'YmMMpM9MMM%=w=,,=MT]M m§;'§,
 * either version 3 of the License,    TWw [.j"5=~N[=§%=%W,T ]R,"=="Y[LFT ]N
 * or (at your option)                   TW=,-#"%=;[  =Q:["V""  ],,M.m == ]N
 * any later version.                      J§"mr"] ,=,," =="""J]= M"M"]==ß"
 *                                          §= "=C=4 §"eM "=B:m|4"]#F,§~
 * Mandelbulber is distributed in            "9w=,,]w em%wJ '"~" ,=,,ß"
 * the hope that it will be useful,                 . "K=  ,=RMMMßM"""
 * but WITHOUT ANY WARRANTY;                            .'''
 * without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with Mandelbulber. If not, see <http://www.gnu.org/licenses/>.
 *
 * ###########################################################################
 *
 * Authors: Krzysztof Marczak (buddhi1980@gmail.com)
 *
 * list of fractal formulas
 */

#ifndef MANDELBULBER2_SRC_FRACTAL_LIST_HPP_
#define MANDELBULBER2_SRC_FRACTAL_LIST_HPP_

#include <utility>

#include <QtCore>

#include "algebra.hpp"
#include "fractal_enums.h"
#include "system.hpp"

namespace fractal
{
enum enumFractalFormula
{
	none = 0,
	fastMandelbulb = 1,
	mandelbulb = 2,
	mandelbulbPower2 = 3,
	hypercomplex = 4,
	quaternion = 5,
	minusFastTrig = 6,
	mengerSponge = 7,
	mandelbox = 8,
	kaleidoscopicIfs = 10,
	xenodreambuie = 11,
	hybrid = 12,
	mandelbulb2 = 13,
	mandelbulb3 = 14,
	mandelbulb4 = 15,
	boxFoldBulbPow2 = 16,
	mandelboxSmooth = 17,
	mandelboxVaryScale4d = 18, // updated V2.10, fix scaleVary v2.12
	aexion = 19,
	benesi = 20,
	bristorbrot = 21,
	invertX = 22,
	invertY = 23,
	invertZ = 24,
	invertR = 25,
	sphericalFold = 26,
	powXYZ = 27,
	scaleX = 28,
	scaleY = 29,
	scaleZ = 30,
	offsetX = 31,
	offsetY = 32,
	offsetZ = 33,
	angleMultiplyX = 34,
	angleMultiplyY = 35,
	angleMultiplyZ = 36,
	generalizedFoldBox = 37,
	oclCustom = 38,
	ides = 39,
	ides2 = 40,
	buffalo = 41,
	quickDudley = 48,
	lkmitch = 49,
	makin3d2 = 50,
	msltoeSym2Mod = 51,
	// mandelbulb5 = 52,
	// mandelbox103 = 53,
	// quaternion104 = 54,
	// mengerSponge105 = 55,
	transfPlatonicSolid = 56,
	// mandelbulb6Beta = 57,
	// benesiTransforms = 58,
	foldBoxMod1 = 59,
	aboxModKali = 60,
	mengerMod1 = 61, // fix V2.10
	quaternion3d = 62,
	aexionOctopusMod = 63,
	aboxMod1 = 64,				 // fix scale v2.11 v2.12
	mandelbulbMulti = 65,	// updated V2.08
	benesiPineTree = 66,	 // updated addCpixel V2.16
	benesiT1PineTree = 67, // updated V2.09, rot2 v2.14
	msltoeSym3Mod = 68,
	msltoeSym4Mod = 69, // fix scal , add mult
	eiffieMsltoe = 70, // updated V2.08. DE v2.15
	riemannSphereMsltoeV1 = 71,
	riemannSphereMsltoe = 72,
	amazingSurf = 73, // fix scale v2.12
	kalisets1 = 74,
	aboxMod2 = 75, // fix scale v2.11, major change v2.12
	aboxVSIcen1 = 76,
	amazingSurfMod1 = 77, // updated V2.08 v2.12
	mandelbulbVaryPowerV1 = 78,
	quaternion4d = 79, // updated V2.10
	msltoeSym3Mod2 = 80,
	msltoeSym3Mod3 = 81, // DE v2.15
	msltoeDonut = 82,
	iqBulb = 83,
	quickDudleyMod = 84,
	// V2.08
	riemannBulbMsltoeMod2 = 85,
	msltoeToroidal = 86,		// update DE v2.15
	aboxModKaliEiffie = 87, // updated z.z scale V2.09
	collatz = 88,
	collatzMod = 89,
	mengerPwr2Poly = 90,	// DE v2.15
	mandelboxMenger = 91, // DE v2.15
	mandelbulbKali = 92,
	mandelbulbKaliMulti = 93,
	mandelbulbBermarte = 94,
	mengerMiddleMod = 95,			// add vary scale v2.19
	msltoeToroidalMulti = 96, // update DE v2.15
	amazingSurfMulti = 97,
	// V2.09
	mengerCrossKIFS = 98,
	mengerPrismShape = 99,		 // fix T1 T1M V2.10. DE v2.15
	benesiMagTransforms = 100, // updated addCpixel V2.16
	pseudoKleinianStdDE = 101, // fix T1 T1M V2.10
	bristorbrot4d = 102,
	pseudoKleinian = 103,				// fix DE V2.10
	pseudoKleinianMod1 = 104,		// fix T1 T1M V2.10 & DE
	benesiPwr2Mandelbulb = 105, // rot2 v2.14, updated addCpixel V2.16
	mengerCrossMod1 = 106,
	// V2.10
	mengerPrismShape2 = 107, // DE v2.15
	mixPinski4d = 108,			 // fixed V2.11
	sierpinski4d = 109,			 // update DE v2.15
	sierpinski3d = 110,			 // update DE v2.15
	menger4d = 111,					 // fixed V2.11
	menger4dMod1 = 112,			 // fixed V2.11
	mengerSmooth = 113,
	mengerSmoothMod1 = 114,
	mengerOcto = 115,
	abox4d = 116, // fixed varyscale v2.12
	// V2.11
	pseudoKleinianMod2 = 117,
	mandelbulbMulti2 = 118, // mbulb default changed V2.12
	aboxMod11 = 119,				// fixed varyscale v2.12
	// V2.12
	mandelbulbQuat = 120, // DE 2.15
	mandelbulbJuliabulb = 121,
	josKleinian = 122,
	aboxMod12 = 123,
	quaternionCubic4d = 124,
	boxFoldBulbPow2V2 = 125,
	boxFoldBulbPow2V3 = 126, // added sphere invert
	aboxMod13 = 127, // add missing sphere fold iter controls
	boxFoldQuat = 128,
	// 2.13
	coastalbrot = 129,
	modulusMengerSponge = 130,
	modulusMandelbulb = 131,
	amazingSurfMod2 = 132, // fixed: comboBox v2.14, type2 v2.17
	// 2.14
	mandelboxVariable = 133,
	boxFold4dBulbPow2 = 134,
	aboxModKaliV2 = 135, // v2.18 add oldZ sign transform
	// 2.15
	aboxModKaliV3 = 136,
	// 2.16
	mandelbulbAbsPower2 = 137,
	mandelbulbPow2V2 = 138,
	riemannSphereMsltoeV2 = 139,
	aboxSurfBox = 140,
	boxFoldBulbMenger = 141,
	vicsek = 142,
	// 2.17
	josKleinianV2 = 143,
	mandelbulbAtan2Power2 = 144,
	bristorbrot2 = 145,
	mandeltorus = 146,
	// 2.18
	amazingSurfMod3 = 147,
	// 2.19
	mandelbulbPower1234 = 148,
	mengerPolyFold = 149,
	ifsXY = 150,

	// 152 to 172 reserved for scator
	scatorPower2Imaginary = 152, // fixed r calc v2.14
	scatorPower2Real = 156, // added V2.15
	scatorPower2 = 173, // added V2.15
	scatorPower2StdR = 174, // added V2.15

	// 2.20
	riemannSphereHoboldPow4 = 180,
	riemannSphereHoboldPow8 = 181,
	mandelbulbKosalos = 182,
	mandelbulbKosalosV2 = 183,
	riemannSphereHoboldMulti = 184,

	// mandelbulber dIFS
	dIFSBoxDiagonalV1 = 600,
	dIFSBoxV1 = 601,
	dIFSBoxDiagonalV3 = 602,
	dIFSCylinder = 603,
	dIFSSphere = 604,


	mandelbulbEye = 800,

	transfAddConstant = 1001,
	transfRotation = 1002,
	transfScale = 1003,
	transfScale3d = 1004,
	transfBoxOffset = 1005,
	transfSphericalOffset = 1006,
	transfAddCpixel = 1007,
	transfAddCpixelAxisSwap = 1008, // fixed V2.09
	transfBenesiT1 = 1009,
	transfBenesiT1Mod = 1010,
	transfBenesiT2 = 1011,
	transfBenesiT3 = 1012,
	transfBenesiT4 = 1013,
	transfBenesiT5b = 1014,
	transfBenesiMagForward = 1015,
	transfBenesiMagBackward = 1016,
	transfBenesiCubeSphere = 1017,
	transfBenesiSphereCube = 1018,
	transfAddCpixelSymmetrical = 1019,
	transfBoxFold = 1020,
	transfSphericalFold = 1021,
	transfZvectorAxisSwap = 1022,
	transfAbsAddConstant = 1023,
	transfNegAbsAddConstant = 1024,
	transfAbsAddTgladFold = 1025, // fixed tweak groupCheck V2.14
	transfMultipleAngle = 1026,
	transfRPower = 1027,
	transfIterationWeight = 1028, // fixed V2.10
	transfAbsAddMulti = 1029,
	transfSphericalPwrFold = 1030,
	transfAddCpixelVaryV1 = 1031,
	transfScaleVaryV1 = 1032,
	transfAddConstantVaryV1 = 1033,
	transfBoxFoldXYZ = 1034,
	transfAddCpixelCxCyAxisSwap = 1035, // fixed V2.09
	transfRotationVaryV1 = 1036,
	transfLinCombineCXYZ = 1037,
	transfSphericalInvC = 1038, // updated V2.12
	transfAddConstant4d = 1039,
	transfBoxFold4d = 1040,
	transfIterationWeight4d = 1041, // fixed V2.10
	transfSphericalFold4d = 1042, // updated V2.11
	transfScale4d = 1043,
	transfAbsAddConstant4d = 1044,
	transfAbsAddTgladFold4d = 1045,
	// v2.08
	transfSurfFoldMulti = 1046,
	transfPwr2Polynomial = 1047,
	transfRotationFoldingPlane = 1048,
	transfSphericalFoldAbox = 1049,
	transfSphericalFoldVaryV1 = 1050,
	transfQuaternionFold = 1051, // changed DE v2.15
	transfMengerFold = 1052, // fixed  v2.15
	// V2.09
	transfInvCylindrical = 1053,
	transfRpow3 = 1054,
	transfSphericalInv = 1055, // fixed modesRadius1 v2.15
	transfFoldingTetra3d = 1056,
	transfBoxFoldVaryV1 = 1057,
	// 2.10
	transfSurfBoxFold = 1058,
	transfOctoFold = 1059, // added aox.r_dz v2.14
	transfScaleVaryVCL = 1060,
	transfSphericalFoldVaryVCL = 1061,
	transfAddExp2Z = 1062, // updated V2.12
	transfReciprocal3 = 1063,
	transfRotationFolding = 1064,
	transfAbsAddConditional = 1065, // scale fixed v2.17
	transfReciprocal4d = 1066,
	transfAbsAddConditional4d = 1067, // scale fixed v2.17
	transfSphericalOffsetVCL = 1068, // fixed v2.14
	transfRotation4d = 1069,
	// 2.11
	transfParabFold = 1070,
	transfScaleVaryV212 = 1071, // updated, renamed V2.12
	transfSphericalFoldCHS = 1072,
	transfSphericalFoldParab = 1073,
	// 2.12
	transfScaleVaryMulti = 1074,
	transfBoxFold4dTglad = 1075,
	transfSphericalFoldCuboid = 1076,
	transfSphericalFoldXYZBias = 1077,
	// 2.13
	transfAddCpixelRotated = 1078,
	transfAddConstantMod1 = 1079,
	// 2.14
	transfPolyFoldSymXY = 1080, // updated v2.19
	transfPolyFoldSymMulti = 1081, // updated v2.19
	// 2.15
	transfSinOrCos = 1082,
	transfSinAndCos = 1083,
	transfSinAndCosMax = 1084,
	transfBlockify = 1085,
	transfAddCpixelScator = 1086,
	transfAddCpixelSinOrCos = 1087,
	// 2.16
	transfSurfBoxFoldV2 = 1088,
	//transfSurfBoxFoldV24d = 1089,
	// 2.17
	transfBoxWrap4d = 1089,
	transfSphericalInvV2 = 1090,
	// 2.18
	transfRotationIterControls = 1091, // fix order of rot v2.20
	transfClamp4d = 1092,
	transfAbsAddMulti4d = 1093,
	transfRotateAboutVec3 = 1094,
	transfOffsetSCurve4d = 1095,
	transfGnarl = 1096,
	transfBoxTiling4d = 1097,
	// 2.19
	transfDiagonalFold = 1098,
	transfPolyFoldAtan = 1099,
	transfPolyFoldAtan2 = 1100,
	transfAbsAddConditional2 = 1101,
	// 2.20
	transfAddConstantMod2 = 1102,
	transfAddConstantRotV1 = 1103,
	transfSurfBoxFoldV24d = 1104, // duplicated number 1089

	// hybrid color trial
	transfHybridColor = 2000,
	transfHybridColor2 = 2001,
	testing = 2100,
	testing4d = 2101,
	testingLog = 2103,
	testingTransform = 2104,


};
}

struct sFractal;
struct sExtendedAux;

using fractalFormulaFcn = void (*)(CVector4 &, const sFractal *, sExtendedAux &);

struct sFractalDescription
{
	QString nameInComboBox;
	QString internalName;
	fractal::enumFractalFormula internalID;
	fractalFormulaFcn fractalFormulaFunction;
	fractal::enumDEType DEType;
	fractal::enumDEFunctionType DEFunctionType;
	fractal::enumCPixelAddition cpixelAddition;
	double defaultBailout;
	fractal::enumDEAnalyticFunction DEAnalyticFunction;
	fractal::enumColoringFunction coloringFunction;

	sFractalDescription(QString _nameInComboBox, QString _internalName,
		fractal::enumFractalFormula _internalID, fractalFormulaFcn _fractalFormulaFunction,
		fractal::enumDEType _DEType, fractal::enumDEFunctionType _DEFunctionType,
		fractal::enumCPixelAddition _cpixelAddition, double _defaultBailout,
		fractal::enumDEAnalyticFunction _DEAnalyticFunction,
		fractal::enumColoringFunction _coloringFunction)
			: nameInComboBox(std::move(_nameInComboBox)),
				internalName(std::move(_internalName)),
				internalID(_internalID),
				fractalFormulaFunction(_fractalFormulaFunction),
				DEType(_DEType),
				DEFunctionType(_DEFunctionType),
				cpixelAddition(_cpixelAddition),
				defaultBailout(_defaultBailout),
				DEAnalyticFunction(_DEAnalyticFunction),
				coloringFunction(_coloringFunction)
	{
	}
	QString getIconName() const
	{
		if (internalID == fractal::none)
		{
			return QString(":system/icons/list-remove.svg");
		}
		return systemData.sharedDir + "formula" + QDir::separator() + "img" + QDir::separator()
					 + internalName + ".png";
	}
	QString getUiFilename() const
	{
		return systemData.sharedDir + "formula" + QDir::separator() + "ui" + QDir::separator()
					 + internalName + ".ui";
	}
	QString getOpenCLFilename() const
	{
		return systemData.sharedDir + "formula" + QDir::separator() + "opencl" + QDir::separator()
					 + internalName + ".cl";
	}
};

extern QList<sFractalDescription> fractalList;

void DefineFractalList(QList<sFractalDescription> *fractalList);

#endif /* MANDELBULBER2_SRC_FRACTAL_LIST_HPP_ */
