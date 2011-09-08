#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
//(c) mafia
int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/TreeVis/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
