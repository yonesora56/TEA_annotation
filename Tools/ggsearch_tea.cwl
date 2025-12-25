#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2
label: "ggsearch for TEA converted FASTA files"
doc: |
  ggsearch command process for TEA converted FASTA files.
  (1) more details: https://github.com/PickyBinders/tea?tab=readme-ov-file#using-tea-sequences-with-ggsearch
  (2) see also: https://fasta.bioch.virginia.edu/wrpearson/fasta/fasta_guide.pdf
  (3) help: docker run --rm quay.io/biocontainers/fasta3:36.3.8i--h7b50bb2_3 ggsearch36 --help

requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entryname: matcha.mat
        entry: $(inputs.substitution_matrix_file)

baseCommand: [ggsearch36]

arguments:
  - -s
  - matcha.mat
  - -m
  - 8XC
  - -f
  - $(inputs.gap_open)
  - -g
  - $(inputs.gap_extend)
  - -T
  - $(inputs.threads)
  - $(inputs.query_fasta_file.path)
  - $(inputs.target_fasta_file.path)

stdout: $(inputs.output_file_name)

inputs:
  - id: substitution_matrix_file
    type: File
    label: "Substitution matrix file"
    doc: "Substitution matrix file for search."
    default:
      class: File
      location: ../Data/matcha.mat

  - id: gap_open
    type: int
    label: "Gap open"
    doc: "Gap open for search."
    default: 18

  - id: gap_extend
    type: int
    label: "Gap extend"
    doc: "Gap extend for search."
    default: 3

  - id: threads
    type: int
    label: "Threads"
    doc: "Threads for search."
    default: 16

  - id: query_fasta_file
    type: File
    label: "Query FASTA file"
    doc: "Query FASTA file for search."
    default:
      class: File
      location: ../Data/tea_convert_akitsu/Mgigas_akitsu_galba.HypotheticalTrans_tea.fa

  - id: target_fasta_file
    type: File
    label: "Target FASTA file"
    doc: "Target FASTA file for search."
    default:
      class: File
      location: ../Data/tea_convert_uniref50/uniref50.tea.fasta

  - id: output_file_name
    type: string
    label: "Output file name"
    doc: "Output file name for search."
    default: "ggsearch_tea_akitsu_galba_uniref50.tsv"

outputs:
  - id: output_file
    type: File
    label: "Output file"
    doc: "Output file for ggsearch results (tsv format)."
    outputBinding:
      glob: "$(inputs.output_file_name)"

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasta3:36.3.8i--h7b50bb2_3

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/