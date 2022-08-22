process FeatureLinkerUnlabeledQT_openms  {
    label 'openms'
    //label 'process_low'
    tag "$mzMLFile"

    //conda (params.enable_conda ? "bioconda::openms=2.8.0" : null)
    //container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        //'https://depot.galaxyproject.org/singularity/openms:2.8.0--h7ca0330_2' :
        //'quay.io/biocontainers/openms:2.8.0--h7ca0330_2' }"


    input:
    path  featureXMLFile
    //each  path(setting_file) 

    output:
    path "group_features.consensusXML"    , emit: group_features_file
    path "versions.yml"                   , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def inputs_aggregated = featureXMLFile.collect{ "$it" }.join(" ")

    """
    FeatureLinkerUnlabeledQT \\
        -in $inputs_aggregated \\
        -out group_features.consensusXML \\
        $args \\
        -threads $task.cpus


    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        openms: \$( openms --version | sed -e "s/openms v//g" ))
    END_VERSIONS

    """
}

