
describe 'Simple {%= source_name %}', ->

  it 'should inherit from SimpleModule', ->
    {%= source_name %} = simple.{%= source_name %}()
    expect({%= source_name %} instanceof SimpleModule).toBe(true)
