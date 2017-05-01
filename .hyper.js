// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {
    fontSize: 13,
    fontFamily: 'SFMono-Regular, Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',

    cursorShape: 'BEAM',
    cursorBlink: false,
    
    css: ``,
    
    termCSS: `
      x-screen a {
        color: #96b5b4;
      }
    `,

    padding: '12px 14px',

    shell: '/usr/local/bin/bash',
    shellArgs: ['--login'],

    bell: false,

    //
    // Plugin configuration
    //

    summonShortcut: 'CommandOrControl+@',
    hyperStatusLine: {
      footerTransparent: true,
    },
    nordHyper: {
      cursorBlink: false
    },
    hyperTabs: {
      trafficButtons: true,
    },
  },

  plugins: [
    // Theme
    'nord-hyper',

    'hypercwd',
    'hyperlinks',
    'hyper-alt-click',
    'hyper-statusline',
    'hyper-tabs-enhanced',
    'hyperterm-summon',
    'hyperterm-1password',
  ],

  localPlugins: []
};