describe('some suite', function () {
  var suiteWideFoo;

  beforeEach(function () {
    suiteWideFoo = 1;
  });

  it('should equal bar', function () {
    expect(suiteWideFoo).toEqual(1);
  });
});