class DeviceCommands {
  static const SET_DATE_TIME = '<LSAP:STDAT:<DATE_AND_TIME>;/>';
  static const CLEAR_EEPROM = '<LSAP:CLEEPROM:;/>';
  static const SET_LOGGING_TIME_INTVL =
      '<LSAP:STLTIVL:<INTERVAL_IN_MINUTE>;/>'; //<LSAP:STLTIVL:1;/>
  static const READ_EEPROM = '<LSAP:RDEEPROM:;/>';
  static const CALIBRATE_DEVICE = '<LSAP:CLBDVCE:;/>';
  static const SUCCESS_RESPOSE = '<LSAP:SUCCESS:;/>';
  static const FAILED_RESPOSE = '<LSAP:FAIL:;/>';
}
