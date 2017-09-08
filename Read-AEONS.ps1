Add-Type -AssemblyName System.speech

$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer 
$speak.SelectVoice("Microsoft Zira Desktop")

$AeonsURL = "https://aeon.co/"
$AeonsWebSite = Invoke-WebRequest -Uri $AeonsURL #-UseBasicParsing
#$ArticlesHTMLS = $AeonsWebSite.parsedhtml.body.GetElementsByClassName("article-card__inner")
$ArticlesHTMLS = ($AeonsWebSite.ParsedHtml.getElementsByTagName('div') | Where{ $_.className -eq 'article-card__inner' } )
[System.Collections.ArrayList]$Articles = @()

foreach($ArticlesHTML in $ArticlesHTMLS) {
    $Title = ($ArticlesHTML.GetElementsByClassName("article-card__title") | Select-Object innerText).innerText
    $Link = $AeonsURL + (($ArticlesHTML.GetElementsByClassName("article-card__link") | Select-Object href).href).Replace("about:/", "")
    #Write-Host "$Title : $Link"
    $null = $Articles.Add((New-Object -TypeName PSObject -Property @{
        Title = $Title
        Link = $Link
    }))
}

$Choice = $Articles | Out-GridView -Title "Lequel?" -PassThru

if($Choice) {
    $ArticleURL = $Choice.Link
    $Content = Invoke-WebRequest -Uri $ArticleURL #-UseBasicParsing
    $ArticleContent = $Content.parsedhtml.body.GetElementsByClassName("has-dropcap")[0,1,2,3,4,5]

    foreach($Sentence in $($ArticleContent.innerText.Split('.'))[0]) {
        $speak.Speak($Sentence)
    }
}

$speak.Dispose()
