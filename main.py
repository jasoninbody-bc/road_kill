#
import os
import sys
path = os.path.join(os.getcwd(), 'vcu_test')
sys.path.insert(0, path)

from os.path import abspath, dirname, join

from PySide2.QtCore import QObject, Slot, Property, Signal, QTimer
from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtGui import QFontDatabase

from vcu_test.utils.manual_ctl import Processor

from threading import Thread
from time import sleep

class Bridge(QObject):
    proc = Processor  # ()
    # Start VCU Code
    vcuLeftMotorValueChanged = Signal()
    vcuRightMotorValueChanged = Signal()
    vcuSweeperMotorValueChanged = Signal()
    vcuActuatorValueChanged = Signal()

    signaller_sensor_1 = Signal()
    signaller_sensor_2 = Signal()
    signaller_sensor_3 = Signal()
    signaller_sensor_4 = Signal()
    signaller_sensor_5 = Signal()
    signaller_sensor_6 = Signal()

    signaller_left_bumper = Signal()
    signaller_right_bumper = Signal()
    signaller_e_stop = Signal()
    signaller_blue_button = Signal()

    signaller_connection_indicator = Signal()
    signaller_version = Signal()
    # End VCU Code

    signaller_log_box =  Signal()

    def __init__(self):
        QObject.__init__(self)
        # Start VCU Code
        self.m_vcuLeftMotorValue = 0.0
        self.vcuLeftMotorValueChanged.connect(self.on_vcuLeftMotorValueChanged)
        self.m_vcuRightMotorValue = 0.0
        self.vcuRightMotorValueChanged.connect(self.on_vcuRightMotorValueChanged)
        self.m_vcuSweeperMotorValue = 0.0
        self.vcuSweeperMotorValueChanged.connect(self.on_vcuSweeperMotorValueChanged)
        self.m_vcuActuatorValue = 0.0
        self.vcuActuatorValueChanged.connect(self.on_vcuActuatorValueChanged)

        self._signaller_sensor_1 = False
        self._signaller_sensor_2 = False
        self._signaller_sensor_3 = False
        self._signaller_sensor_4 = False
        self._signaller_sensor_5 = False
        self._signaller_sensor_6 = False

        self._signaller_left_bumper = False
        self._signaller_right_bumper = False
        self._signaller_e_stop = False
        self._signaller_blue_button = False

        self._signaller_connection_indicator = False
        self._signaller_version = 'Version'
        # End VCU CODE
        self._signaller_log_box = ' '

        # Debug remove
        self.logger = Logger()

    # Start VCU CODE
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
            self.updateSensor(True)
        else:
            self.updateSensor(False)
            print('Sensors disabled')

    @Slot(bool)
    def updateSensor(self,val):
        print('updating sensor')
        self._set_signal1(val)
        self._set_signal2(val)
        self._set_signal3(val)
        self._set_signal4(val)
        self._set_signal5(val)
        self._set_signal6(val)
        self._set_left_bumper(val)
        self._set_right_bumper(val)
        self._set_e_stop(val)
        self._set_blue_button(val)
        return True

    # Cliff sensors
    def _get_signal1(self):
        return self._signaller_sensor_1

    def _set_signal1(self, signal):
        print('setting signal')
        self._signaller_sensor_1 = signal
        self.signaller_sensor_1.emit()

    def _get_signal2(self):
        return self._signaller_sensor_2

    def _set_signal2(self, signal):
        print('setting signal')
        self._signaller_sensor_2 = signal
        self.signaller_sensor_2.emit()

    def _get_signal3(self):
        return self._signaller_sensor_3

    def _set_signal3(self, signal):
        print('setting signal')
        self._signaller_sensor_3 = signal
        self.signaller_sensor_3.emit()

    def _get_signal4(self):
        return self._signaller_sensor_4

    def _set_signal4(self, signal):
        print('setting signal')
        self._signaller_sensor_4 = signal
        self.signaller_sensor_4.emit()

    def _get_signal5(self):
        return self._signaller_sensor_5

    def _set_signal5(self, signal):
        print('setting signal')
        self._signaller_sensor_5 = signal
        self.signaller_sensor_5.emit()

    def _get_signal6(self):
        return self._signaller_sensor_6

    def _set_signal6(self, signal):
        print('setting signal')
        self._signaller_sensor_6 = signal
        self.signaller_sensor_6.emit()

    sensor_1 = Property(bool, _get_signal1, _set_signal1, notify=signaller_sensor_1)
    sensor_2 = Property(bool, _get_signal2, _set_signal2, notify=signaller_sensor_2)
    sensor_3 = Property(bool, _get_signal3, _set_signal3, notify=signaller_sensor_3)
    sensor_4 = Property(bool, _get_signal4, _set_signal4, notify=signaller_sensor_4)
    sensor_5 = Property(bool, _get_signal5, _set_signal5, notify=signaller_sensor_5)
    sensor_6 = Property(bool, _get_signal6, _set_signal6, notify=signaller_sensor_6)

    # End Cliff sensors
    # Bumper Sensors

    def _get_left_bumper(self):
        return self._signaller_left_bumper

    def _set_left_bumper(self, signal):
        print('setting left bumper')
        self._signaller_left_bumper = signal
        self.signaller_left_bumper.emit()

    def _get_right_bumper(self):
        return self._signaller_right_bumper

    def _set_right_bumper(self, signal):
        print('setting right bumper')
        self._signaller_right_bumper = signal
        self.signaller_right_bumper.emit()

    left_bumper = Property(bool, _get_left_bumper, _set_left_bumper, notify=signaller_left_bumper)
    right_bumper = Property(bool, _get_right_bumper, _set_right_bumper, notify=signaller_right_bumper)

    # End Bumper sensors
    def _get_e_stop(self):
        return self._signaller_left_bumper

    def _set_e_stop(self, signal):
        print('setting e stop')
        self._signaller_e_stop = signal
        self.signaller_e_stop.emit()

    def _get_blue_button(self):
        return self._signaller_blue_button

    def _set_blue_button(self, signal):
        print('setting right bumper')
        self._signaller_blue_button = signal
        self.signaller_blue_button.emit()

    e_stop = Property(bool, _get_e_stop, _set_e_stop, notify=signaller_e_stop)
    blue_button = Property(bool, _get_blue_button, _set_blue_button, notify=signaller_blue_button)

    # End Sensor Code

    # Connection code
    @Slot()
    def vcuConnect(self):
        print('Checking VCU connection')
        self._set_connection_indicator(True)

    @Slot()
    def vcuGetVersion(self):
        print('Getting VCU Version')
        self._set_version('1.0.0.0')

    @Slot()
    def vcuAutoRunTest(self):
        print('Running Autotest')
        thread = Thread(target=self.logger.createLog, args=(self._set_log_box,))
        thread.start()

    @Slot()
    def vcuReboot(self):
        print('VCU Reboot')

    def _get_connection_indicator(self):
        return self._signaller_connection_indicator

    def _set_connection_indicator(self, signal):
        print('setting signal')
        self._signaller_connection_indicator = signal
        self.signaller_connection_indicator.emit()

    def _get_version(self):
        return self._signaller_version

    def _set_version(self, signal):
        print('setting signal')
        self._signaller_version = signal
        self.signaller_version.emit()

    version = Property(str, _get_version, _set_version, notify=signaller_version)
    connection_indicator = Property(bool, _get_connection_indicator, _set_connection_indicator, notify=signaller_connection_indicator)
    # End Connection code
    # End VCU CODE

    # Text Logging
    def _get_log_box(self):
        return self._signaller_log_box

    def _set_log_box(self, signal):
        print('setting signal')
        self._signaller_log_box = signal
        self.signaller_log_box.emit()

    log_box = Property(str, _get_log_box, _set_log_box, notify=signaller_log_box)

import datetime
class Logger():
    def createLog(self, set_log_box):
        time_log = ''
        while True:
            time_log = time_log + '\n' + str(datetime.datetime.now())
            set_log_box(time_log)
            print(str(datetime.datetime.now()))
            sleep(0.5)


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