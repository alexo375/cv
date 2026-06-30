$max_repeat = 5;
$bibtex_use = 2;

my $engine = $ENV{'ENGINE'} // 'pdflatex';

if ($engine eq 'pdflatex') {
    $pdflatex = 'pdflatex -interaction=nonstopmode -file-line-error -synctex=1 -shell-escape %O %S';
    $pdf_mode = 1;
}
elsif ($engine eq 'lualatex') {
    $pdflatex = 'lualatex -interaction=nonstopmode -file-line-error -synctex=1 -shell-escape %O %S';
    $pdf_mode = 4;
}
elsif ($engine eq 'xelatex') {
    $pdflatex = 'xelatex -interaction=nonstopmode -file-line-error -synctex=1 -shell-escape %O %S';
    $pdf_mode = 5;
}
else {
    die "Unsupported ENGINE=$engine. Use pdflatex, lualatex or xelatex.";
}
