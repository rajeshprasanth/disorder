function gk = m_lj_cond_alloy_gk_results
%gk = m_lj_gk_alloy_results
%returns the gk thermal conductivity results @ 10K for 4-12x systems
%--------------------------------------------------------------------------

%pressure correction
%0.5, 8x      0.2573 / 0.2153

% GK.pressure_correction = 0.2573 / 0.2153;
% 
% P1 = -8
% 
% P2 = 

gk.conc =[...
    0
    0.05
    0.15
    0.5
    ];

gk.size =[...
    4
    6
    8
    10
    12
    ];

gk.extrap =[...
3.20
0.7982
0.4576
0.3839
];

gk.cond(:,1) =[...
    3.1306
    3.2109
    3.2384
    3.1898
    3.2405
    ];
%extrapolate 3.3
gk.cond(:,2) =[...
    0.6909
    0.7194
    0.7243
    0.7494
    0.7700
    ];
%extrapolate 0.75
gk.cond(:,3) =[...
    0.2887
    0.3194
    0.3457
    0.3771
    0.3832
    ];
%extrapolate 0.35
gk.cond(:,4) =[...
    0.1801
    0.2283
    0.2481
    0.2683
    0.2729
    ];
%extrapolate 0.28


% GK(5).size =[...
%     4
%     8
%     10
%     12
%     ];
% 
% GK(5).conc =[...
%     0
%     0.05
%     0.15
%     0.5
%     ];
% 
% GK(5).cond =[...
%     0.16656 0.033505
%     0.16844 0.00038194
%     0.17869 0.013507
%     0.17053 0.0096541
%     ];


end



    
