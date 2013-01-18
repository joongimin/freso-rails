module GuideStep
  include Application::Enum

  GuideStep.define :CREATE_BRAND, 1
  GuideStep.define :SELECT_LAYOUT, 2
  GuideStep.define :CUSTOMIZE, 3
  GuideStep.define :ADD_PRODUCT, 4
end