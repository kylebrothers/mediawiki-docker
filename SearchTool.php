<?php
 
$wgExtensionFunctions[] = "wfSearchTool";
 
$wgExtensionCredits['parserhook'][] =
  array(
        'name'        => 'SearchTool',
        'author'      => array( 'The MediaWiki Community', 'Dan Bolser' ),
        'url'         => 'http://www.mediawiki.org/wiki/Extension:Google',
        'description' => 'Allow inclusion of a multiple searches.',
        );
 
function wfSearchTool() {
  global $wgParser;
 
  $wgParser->setHook( "SearchTool", "wfRenderGoogleSearch" );
}
 
# The callback function for converting the input text to HTML output                                                                    
function wfRenderGoogleSearch( $input, $args, $parser ) {
  $site = $args['site'] ;
  $submit = $args['submit'] ;

  $output  = '<!-- Search the indicated site -->';
  $output .= '<form method="GET" action="'. $site. '">';
  $output .= '<div class="form-row">';
  $output .= '<div class="col-12 col-md-8">';
  $output .= '        <input type="text" class="form-control" name="q" value="'. $input. '"/>';
  $output .= '</div>';
  $output .= '<div class="col-6 col-md-4">';
  $output .= '        <input class="btn btn-info btn-block"  type="submit" value="'. $submit. '"/>';
  $output .= '</div>';
  $output .= '</div>';
  $output .= '</form>';
 # $output .= '</center>';
  $output .= '<!-- Search Google -->';
  return $output;
}
