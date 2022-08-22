#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { PeakPickerHiRes_openms } from './modules/PeakPickerHiRes_openms.nf'
include { FeatureFinderMetabo_openms } from './modules/FeatureFinderMetabo_openms.nf'
include { MapAlignerPoseClustering_openms } from './modules/MapAlignerPoseClustering_openms.nf'
include { FeatureLinkerUnlabeledQT_openms } from './modules/FeatureLinkerUnlabeledQT_openms.nf'


workflow test_PeakPickerHiRes_openms {

  input_test = Channel.fromPath( '*.mzML')

    //setting_file_test = Channel.fromPath('*.ini')
  
  PeakPickerHiRes_openms(input_test)
  
}

workflow test_FeatureFinderMetabo_openms {

  input_test2 = Channel.fromPath( '*.mzML')

    //setting_file_test = Channel.fromPath('*.ini')
  
  FeatureFinderMetabo_openms(input_test2)
  
}

workflow test_MapAlignerPoseClustering_openms {

  input_test3 = Channel.fromPath( '*.mzML')

    //setting_file_test = Channel.fromPath('*.ini')
  
  MapAlignerPoseClustering_openms(input_test3)
  
}


workflow test_FeatureLinkerUnlabeledQT_openms {

  input_test4 = Channel.fromPath( '*.featureXML')

    //setting_file_test = Channel.fromPath('*.ini')
  
  FeatureLinkerUnlabeledQT_openms(input_test4)
  
}