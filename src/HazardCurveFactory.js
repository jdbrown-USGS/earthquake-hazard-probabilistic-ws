'use strict';

var HazardCurveFactory = function (options) {
  var _this,
      _initialize;

  _this = {};

  _initialize = function (options) {
    _this.db = options.db;
  };


  _this.getCurve = function (/*latitude, longitude, edition, region, vs30*/) {
    process.stderr.write('fetching curve from data base\n');
    return _this.db.query('select * from curve limit 1').then((result) => {
      process.stderr.write('returning curve\n');
      return result;
    });
  };

  _this.getRegions = function () {
    return Promise.resolve([{
      value: 'COUS'
    }]);
  };

  _this.getSpectralPeriods = function () {
    return Promise.resolve([
      {
        value: 'PGA'
      },
      {
        value: 'SA0P2'
      },
      {
        value: 'SA1P0'
      }
    ]);
  };


  _initialize(options);
  options = null;
  return _this;
};

module.exports = HazardCurveFactory;
