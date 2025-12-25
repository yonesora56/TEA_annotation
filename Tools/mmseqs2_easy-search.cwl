#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2
label: "MMseqs2 easy-search for TEA converted FASTA files"
doc: |
  MMseqs2 easy-search command process for TEA converted FASTA files.
  more details: https://github.com/PickyBinders/tea?tab=readme-ov-file#using-tea-sequences-with-mmseqs2
  help: docker run --rm quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0 mmseqs easy-search --help
  command example: mmseqs easy-search tea_query.fasta tea_target.fasta results.m8 tmp/ --format-mode 4 --comp-bias-corr 0 --mask 0 --gap-open 18 --gap-extend 3 --sub-mat /path/to/matcha.out --seed-sub-mat /path/to/matcha.out --exact-kmer-matching 1

baseCommand: [mmseqs, easy-search]
arguments:
  - $(inputs.query_fasta_file)
  - $(inputs.target_fasta_file)
  - $(inputs.output_file_name)
  - $(runtime.tmpdir)
  - --format-mode
  - $(inputs.format_mode)
  - --format-output
  - $(inputs.format_output)
  - --comp-bias-corr
  - $(inputs.comp_bias_corr)
  - --mask
  - $(inputs.mask)
  - --gap-open
  - $(inputs.gap_open)
  - --gap-extend
  - $(inputs.gap_extend)
  - --sub-mat
  - $(inputs.substitution_matrix_file)
  - --seed-sub-mat
  - $(inputs.substitution_matrix_file)
  - --exact-kmer-matching
  - $(inputs.exact_kmer_matching)
  - --threads
  - $(inputs.threads)

inputs:
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
      location: ../Data/tea_convert_uniref50/uniref50.tea.fasta.gz

  - id: output_file_name
    type: string
    label: "Output file name"
    doc: "Output file name for search."
    default: "mmseqs2_easy_search_akitsu_galba_uniref50.tsv"

  - id: format_mode
    type: int
    label: "Format mode"
    doc: "Format mode for search."
    default: 4

  - id: format_output
    type: string
    label: "Format output"
    doc: "Format output for search."
    default: "query,target,pident,fident,nident,qcov,tcov,alnlen,mismatch,gapopen,qlen,qstart,qend,tlen,tstart,tend,evalue,bits,qheader,theader"

  - id: comp_bias_corr
    type: int
    label: "Comp bias correction"
    doc: "Comp bias correction for search."
    default: 0

  - id: mask
    type: int
    label: "Mask"
    doc: "Mask for search."
    default: 0

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
      location: ../Data/matcha.out

  - id: exact_kmer_matching
    type: int
    label: "Exact kmer matching"
    doc: "Exact kmer matching for search."
    default: 1

  - id: threads
    type: int
    label: "Threads"
    doc: "Threads for search."
    default: 16
    

outputs:
  - id: output_file
    type: File
    label: "Output file"
    doc: "Output file for mmseqs2 easy-search results (tsv format)."
    outputBinding:
      glob: "$(inputs.output_file_name)"


hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmseqs2:18.8cc5c--hd6d6fdc_0

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/