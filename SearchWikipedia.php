<?php
 
$wgExtensionFunctions[] = "wfSearchWikipedia";
 
$wgExtensionCredits['parserhook'][] =
  array(
        'name'        => 'SearchWikipedia',
        'author'      => array( 'The MediaWiki Community', 'Dan Bolser' ),
        'url'         => 'http://www.mediawiki.org/wiki/Extension:Google',
        'description' => 'Allow inclusion of a wikipedia searches.',
        );
 
function wfSearchWikipedia() {
  global $wgParser;
 
  $wgParser->setHook( "SearchWikipedia", "wfRenderWikipediaSearch" );
}
 
# The callback function for converting the input text to HTML output                                                                    
function wfRenderWikipediaSearch( $input, $args, $parser ) {
  $output  = '<!-- Search the indicated site -->';
  $output .= '<form action="http://en.wikipedia.org/wiki/Special:Search" id="searchform">';
  $output .= '<div class="form-row">';
  $output .= '<div class="col-12 col-md-8">';
  $output .= '        <input title="Search Wikipedia [f]" accesskey="f" value="" type="text" class="form-control" name="search"/>';
  $output .= '</div>';
  $output .= '<div class="col-6 col-md-4">';
  $output .= '            <input class="btn btn-info btn-block"  name="go" type="submit" value="Wikipedia"/>';
  $output .= '</div>';
  $output .= '</div>';
  $output .= '</form>';
  $output .= '<!-- Search Google -->';
  return $output;
}
