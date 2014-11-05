
describe 'Simple Sample', ->

  it 'should inherit from SimpleModule', ->
    sample = simple.sample()
    expect(sample instanceof SimpleModule).toBe(true)
