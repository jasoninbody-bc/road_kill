#
import os
import sys
path = os.path.join(os.getcwd(), 'vcu_test')
sys.path.insert(0, path)

from os.path import abspath, dirname, join

from PySide2.QtCore import QObject, Slot, Property, Signal
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtGui import QFontDatabase

from vcu_test.utils.manual_ctl import Processor


class Bridge(QObject):
    proc = Processor  # ()
    vcuLeftMotorValueChanged = Signal()
    vcuRightMotorValueChanged = Signal()
    vcuSweeperMotorValueChanged = Signal()
    vcuActuatorValueChanged = Signal()

    vcuSensorS1 = False

    def __init__(self):
        QObject.__init__(self)
        self.m_vcuLeftMotorValue = 0.0
        self.vcuLeftMotorValueChanged.connect(self.on_vcuLeftMotorValueChanged)
        self.m_vcuRightMotorValue = 0.0
        self.vcuRightMotorValueChanged.connect(self.on_vcuRightMotorValueChanged)
        self.m_vcuSweeperMotorValue = 0.0
        self.vcuSweeperMotorValueChanged.connect(self.on_vcuSweeperMotorValueChanged)
        self.m_vcuActuatorValue = 0.0
        self.vcuActuatorValueChanged.connect(self.on_vcuActuatorValueChanged)

    # Start VCU Left motor code
    @Property(float, notify=vcuLeftMotorValueChanged)
    def vcuLeftMotorValue(self):
        print(self.m_vcuLeftMotorValue)
        return self.m_vcuLeftMotorValue

    @vcuLeftMotorValue.setter
    def setVcuLeftMotorValue(self, val):
        if self.m_vcuLeftMotorValue == val:
            return
        print(val)
        self.m_vcuLeftMotorValue = val
        self.vcuLeftMotorValueChanged.emit()

    @Slot()
    def on_vcuLeftMotorValueChanged(self):
        print(self.m_vcuLeftMotorValue)

    @Slot()
    def vcuRunLeftMotor(self):
        self.motor_lspeed = 1
        print('running left motor')

    # Start VCU Right motor code
    @Property(float, notify=vcuRightMotorValueChanged)
    def vcuRightMotorValue(self):
        print(self.m_vcuRightMotorValue)
        return self.m_vcuRightMotorValue

    @vcuRightMotorValue.setter
    def setVcuRightMotorValue(self, val):
        if self.m_vcuRightMotorValue == val:
            return
        print(val)
        self.m_vcuRightMotorValue = val
        self.vcuRightMotorValueChanged.emit()

    @Slot()
    def on_vcuRightMotorValueChanged(self):
        print(self.m_vcuRightMotorValue)

    @Slot()
    def vcuRunRightMotor(self):
        self.motor_rspeed = 1
        print('running right motor')

    # Start VCU Sweeper motor code
    @Property(float, notify=vcuSweeperMotorValueChanged)
    def vcuSweeperMotorValue(self):
        print(self.m_vcuSweeperMotorValue)
        return self.m_vcuSweeperMotorValue

    @vcuSweeperMotorValue.setter
    def setVcuSweeperMotorValue(self, val):
        if self.m_vcuSweeperMotorValue == val:
            return
        print(val)
        self.m_vcuSweeperMotorValue = val
        self.vcuSweeperMotorValueChanged.emit()

    @Slot()
    def on_vcuSweeperMotorValueChanged(self):
        print(self.m_vcuSweeperMotorValue)

    @Slot()
    def vcuRunSweeper(self):
        self.sweeper_speed = 1
        print('running sweeper')

    # Start Actuator control code
    @Property(float, notify=vcuActuatorValueChanged)
    def vcuActuatorValue(self):
        print(self.m_vcuActuatorValue)
        return self.m_vcuActuatorValue

    @vcuActuatorValue.setter
    def setVcuActuatorValue(self, val):
        if self.m_vcuActuatorValue == val:
            return
        print(val)
        self.m_vcuActuatorValue = val
        self.vcuActuatorValueChanged.emit()

    @Slot()
    def on_vcuActuatorValueChanged(self):
        print(self.m_vcuActuatorValue)

    # VCU Vacuum controls
    @Slot()
    def vcuVacuumOff(self):
        self.vacuum_speed = 0
        print('vacuum off')

    @Slot()
    def vcuVacuumOn(self):
        self.vacuum_speed = 1
        print('vacuum on')

    @Slot()
    def vcuVacuumTurbo(self):
        self.vacuum_speed = 2
        print('vacuum turbo')

    # Start Sensor Code
    @Slot(bool)
    def vcuEnableSensors(self, enabled):
        if enabled:
            print('Sensors enabled')
            self.vcuSensorS1 = True
        else:
            print('Sensors disabled')


#         if s.lower() == "red":
#             return "#ef9a9a"
#         elif s.lower() == "green":
#             return "#a5d6a7"
#         elif s.lower() == "blue":
#             return "#90caf9"
#         else:
#             return "white"
#
#     @Slot(float, result=int)
#     def getSize(self, s):
#         size = int(s * 34)
#         if size <= 0:
#             return 1
#         else:
#             return size
#
#     @Slot(str, result=bool)
#     def getItalic(self, s):
#         if s.lower() == "italic":
#             return True
#         else:
#             return False
#
#     @Slot(str, result=bool)
#     def getBold(self, s):
#         if s.lower() == "bold":
#             return True
#         else:
#             return False
#
#     @Slot(str, result=bool)
#     def getUnderline(self, s):
#         if s.lower() == "underline":
#             return True
#         else:
#             return False


if __name__ == '__main__':
    sys.argv += ['--style', 'material']
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # # Instance of the Python object
    interface = Bridge()

    # Expose the Python object to QML
    context = engine.rootContext()
    context.setContextProperty("pythonBridge", interface)
    QFontDatabase.addApplicationFont(":/materialdesignicons-webfont.ttf")
    # Get the path of the current directory, and then add the name
    # of the QML file, to load it.
    qmlFile = join(dirname(__file__), 'view.qml')
    engine.load(abspath(qmlFile))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())