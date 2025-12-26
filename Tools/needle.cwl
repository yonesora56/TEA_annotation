#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2
label: "EMBOSS needle for TEA converted FASTA files"
doc: |
  EMBOSS needle command process for TEA converted FASTA files.
  more details: https://www.bioinformatics.nl/cgi-bin/emboss/help/needle
  help: docker run --rm quay.io/biocontainers/emboss:6.6.0--h0f19ade_14 needle --help

requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entryname: matcha.mat
        entry: $(inputs.substitution_matrix_file)


baseCommand: [needle]
arguments:
  - -asequence
  - $(inputs.query_fasta_file)
  - -bsequence
  - $(inputs.target_fasta_file)
  - -gapopen
  - $(inputs.gap_open)
  - -gapextend
  - $(inputs.gap_extend)
  - -outfile
  - $(inputs.output_file_name)
  - -datafile
  - matcha.mat
  - -nobrief
#   - -aformat
#   - $(inputs.output_format)
  - -awidth
  - $(inputs.alignment_width)

inputs:
  - id: query_fasta_file
    type: File
    label: "Query FASTA file"
    doc: "Query FASTA file for search."
    default:
      class: File
      location: ../Data/PDB_fasta/1u4a_A_tea.fasta
      
  - id: target_fasta_file
    type: File
    label: "Target FASTA file"
    doc: "Target FASTA file for search."
    default:
      class: File
      location: ../Data/PDB_fasta/1d3z_A_tea.fasta
      
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
    
  - id: substitution_matrix_file
    type: File
    label: "Substitution matrix file"
    doc: "Substitution matrix file for search."
    default:
      class: File
      location: ../Data/matcha.mat

  - id: output_file_name
    type: string
    label: "Output file name"
    doc: "Output file name for search."
    default: "needle_1u4a_A_1d3z_A.needle"

#   - id: output_format
#     type: string
#     label: "Output format"
#     doc: "Output alignment format. Options: srspair (default), markx10 (detailed), pair, etc."
#     default: "markx10"

  - id: alignment_width
    type: int
    label: "Alignment width"
    doc: "Width of alignment output (number of characters per line)."
    default: 100

outputs:
  - id: output_file
    type: File
    label: "Output file"
    doc: "Output file for needle results (tsv format)."
    outputBinding:
      glob: "$(inputs.output_file_name)"


hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emboss:6.6.0--h0f19ade_14