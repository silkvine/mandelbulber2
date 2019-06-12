/*
 * palette_edit_widget.cpp
 *
 *  Created on: 1 cze 2019
 *      Author: krzysztof
 */

#include <QPainter>
#include <QMouseEvent>
#include <QColorDialog>

#include "palette_edit_widget.h"
#include "src/system.hpp"

cPaletteEditWidget::cPaletteEditWidget(QWidget *parent) : QWidget(parent)
{
	mouseDragStarted = false;
	pressedColorIndex = 0;
	dragStartX = 0;

	int fixHeight = systemData.GetPreferredThumbnailSize() / 2;
	setFixedHeight(fixHeight);

	buttonWidth = fixHeight / 6;
	if (buttonWidth % 2 == 0) buttonWidth += 1; // to always have odd width

	margins = buttonWidth / 2 + 2;
}

cPaletteEditWidget::~cPaletteEditWidget()
{
	// TODO Auto-generated destructor stub
}

void cPaletteEditWidget::paintEvent(QPaintEvent *event)
{
	int gradientWidth = width() - 2 * margins;
	if (gradientWidth < 2) gradientWidth = 2;
	int gradientHeight = height() / 2;

	QPainter painter(this);
	QVector<sRGB16> grad = gradient.GetGradient(gradientWidth, true);

	for (int x = 0; x < grad.size(); x++)
	{
		QColor color(QColor(grad[x].R / 256, grad[x].G / 256, grad[x].B / 256));
		painter.setPen(color);
		painter.drawLine(x + margins, 0, x + margins, gradientHeight);
	}

	QList<cColorGradient::sColor> listOfColors = gradient.GetListOfColors();
	for (cColorGradient::sColor posColor : listOfColors)
	{
		PaintButton(posColor, painter);
	}
}

int cPaletteEditWidget::CalcButtonPosition(double position)
{
	return margins + position * (width() - 2 * margins - 1);
}

void cPaletteEditWidget::PaintButton(const cColorGradient::sColor &posColor, QPainter &painter)
{
	int buttonPosition = CalcButtonPosition(posColor.position);

	int buttonTop = height() / 2 + buttonWidth / 2;

	QRect rect(QPoint(buttonPosition - buttonWidth / 2, buttonTop),
		QPoint(buttonPosition + buttonWidth / 2, height() - 2));

	QColor color(posColor.color.R / 256, posColor.color.G / 256, posColor.color.B / 256);

	QBrush brush(color, Qt::SolidPattern);
	painter.fillRect(rect, brush);

	QVector<QPoint> triangle = {QPoint(buttonPosition, height() / 2),
		QPoint(buttonPosition - buttonWidth / 2, buttonTop),
		QPoint(buttonPosition + buttonWidth / 2, buttonTop)};
	QPolygon pTriangle(triangle);
	QPainterPath pathTriangle;
	pathTriangle.addPolygon(pTriangle);
	painter.fillPath(pathTriangle, brush);

	int avgColor = (posColor.color.R + posColor.color.G + posColor.color.B) / 3;
	if (avgColor > 10000)
		painter.setPen(Qt::black);
	else
		painter.setPen(Qt::white);

	painter.drawRect(rect);
}

int cPaletteEditWidget::FindButtonAtPosition(int x)
{
	QList<cColorGradient::sColor> listOfColors = gradient.GetListOfColors();

	for (int i = 0; i < listOfColors.size(); i++)
	{
		int xButton = CalcButtonPosition(listOfColors[i].position);
		if ((x > xButton - buttonWidth / 2) && (x <= xButton + buttonWidth / 2))
		{
			return i;
		}
	}
	return -1; //-1 means nothing found
}

void cPaletteEditWidget::mouseMoveEvent(QMouseEvent *event)
{
	if (pressedColorIndex >= 2)
	{
		if (event->x() != dragStartX)
		{
			mouseDragStarted = true;
		}

		if (mouseDragStarted)
		{
			double pos = double(event->x() - margins) / (width() - 2 * margins - 1);
			gradient.ModifyPosition(pressedColorIndex, pos);
			emit update();
		}
	}
}

void cPaletteEditWidget::mousePressEvent(QMouseEvent *event)
{
	int mouseX = event->x();
	int mouseY = event->y();

	if (mouseY > height() / 2)
	{
		int index = FindButtonAtPosition(mouseX);
		dragStartX = mouseX;
		pressedColorIndex = index;
	}
}

void cPaletteEditWidget::mouseReleaseEvent(QMouseEvent *event)
{
	if (pressedColorIndex >= 0 && !mouseDragStarted)
	{
		QList<cColorGradient::sColor> listOfColors = gradient.GetListOfColors();

		QColorDialog colorDialog(this);
		colorDialog.setOption(QColorDialog::DontUseNativeDialog);
		sRGB16 colorRGB = listOfColors[pressedColorIndex].color;
		QColor color(colorRGB.R / 256, colorRGB.G / 256, colorRGB.B / 256);
		colorDialog.setCurrentColor(color);
		colorDialog.setWindowTitle(tr("Edit color #%1").arg(QString::number(pressedColorIndex + 1)));
		if (colorDialog.exec() == QDialog::Accepted)
		{
			color = colorDialog.currentColor();
			colorRGB = sRGB16(color.red() * 256, color.green() * 256, color.blue() * 256);
			gradient.ModifyColor(pressedColorIndex, colorRGB);

			if (pressedColorIndex == 0) gradient.ModifyColor(1, colorRGB);

			if (pressedColorIndex == 1) gradient.ModifyColor(0, colorRGB);

			emit update();
		}
	}

	pressedColorIndex = -1;
	mouseDragStarted = false;
}
