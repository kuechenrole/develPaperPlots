function [s,wt] = sample(element,nip,ndim)

% returns the local coordinates (s) and weighting coefficients (wt)
% of the integrating points.

%
% see also: http://people.sc.fsu.edu/~jburkardt/datasets/quadrature_rules_tri/quadrature_rules_tri.html
%           http://people.sc.fsu.edu/~jburkardt/m_src/triangle_nco_rule/triangle_nco_rule.html
%           http://people.sc.fsu.edu/~jburkardt/m_src/triangle_wandzura_rule/triangle_wandzura_rule.html
%           https://arxiv.org/abs/1411.5631
%


warning('Ua:sample:DoNotUse','Try not to use sample') 

s=zeros(nip,ndim)     ; % coordinates of integration points
wt=zeros(nip,1) ;       % weights

root3=0.577350269189626;   % 1.0/sqrt(3.0);
r15=0.774596669241483 ;    % 0.2*sqrt(15.0);

%w=(/5.0/9.0,8.0/9.0,5.0/9.0/)
%v=(/5.0/9.0*w,8.0/9.0*w,5.0/9.0*w/)

w=[5.0/9.0,8.0/9.0,5.0/9.0];       % 3 elements
v=[5.0/9.0*w,8.0/9.0*w,5.0/9.0*w]; % 9 elements




switch element
    case 'line'
        switch  nip
            case 1
                s(1,1)=0.0;
                wt(1) =2.0;
            case 2
                s(1,1)=-0.577350269189626;
                s(2,1)= 0.577350269189626;
                wt(1) = 1.000000000000000;
                wt(2) = 1.000000000000000;
            case 3
                s(1,1)=-0.774596669241484;
                s(2,1)= 0.000000000000000;
                s(3,1)= 0.774596669241484;
                wt(1) = 0.555555555555556;
                wt(2) = 0.888888888888889;
                wt(3) = 0.555555555555556;
            case 4
                s(1,1)=-0.861136311594053;
                s(2,1)=-0.339981043584856;
                s(3,1)= 0.339981043584856;
                s(4,1)= 0.861136311594053;
                wt(1) = 0.347854845137454;
                wt(2) = 0.652145154862546;
                wt(3) = 0.652145154862546;
                wt(4) = 0.347854845137454;
            case 5
                s(1,1)=-0.906179845938664;
                s(2,1)=-0.538469310105683;
                s(3,1)= 0.000000000000000;
                s(4,1)= 0.538469310105683;
                s(5,1)= 0.906179845938664;
                wt(1) = 0.236926885056189;
                wt(2) = 0.478628670499366;
                wt(3) = 0.568888888888889;
                wt(4) = 0.478628670499366;
                wt(5) = 0.236926885056189;
            case 6
                s(1,1)=-0.932469514203152;
                s(2,1)=-0.661209386466265;
                s(3,1)=-0.238619186083197;
                s(4,1)= 0.238619186083197;
                s(5,1)= 0.661209386466265;
                s(6,1)= 0.932469514203152;
                wt(1) = 0.171324492379170;
                wt(2) = 0.360761573048139;
                wt(3) = 0.467913934572691;
                wt(4) = 0.467913934572691;
                wt(5) = 0.360761573048139;
                wt(6) = 0.171324492379170;
            otherwise
                disp(' Wrong number of integrating points for a line' )
        end
    case 'triangle'  % 1,3,4,6,7,9,12,13,16,19,28,37
        switch nip
            case 1
                s(1,1)= 0.333333333333333;
                s(1,2)= 0.333333333333333;
                wt(1) = 0.500000000000000;
            case 3  % order 3, degree of precision 2.
                s(1,1)= 0.500000000000000;
                s(1,2)= 0.500000000000000;
                s(2,1)= 0.500000000000000;
                s(2,2)= 0.000000000000000;
                s(3,1)= 0.000000000000000;
                s(3,2)= 0.500000000000000;
                wt(1:3)=0.333333333333333;
                wt=0.5*wt;
            case 4  % order 4, degree of precision 3
                s(1,1)= 0.6;
                s(1,2)= 0.2;
                s(2,1)= 0.2;
                s(2,2)= 0.6;
                s(3,1)= 0.2;
                s(3,2)= 0.2;
                s(4,1)= 0.333333333333333;
                s(4,2)= 0.333333333333333;
                wt(1:3)= 0.520833333333333;
                wt(4)=  -0.5625;
                wt=0.5*wt;
            case 6   % order 6, degree of precision 4.
                s(1,1)= 0.816847572980459;
                s(1,2)= 0.091576213509771;
                s(2,1)= 0.091576213509771;
                s(2,2)= 0.816847572980459;
                s(3,1)= 0.091576213509771;
                s(3,2)= 0.091576213509771;
                s(4,1)= 0.108103018168070;
                s(4,2)= 0.445948490915965;
                s(5,1)= 0.445948490915965;
                s(5,2)= 0.108103018168070;
                s(6,1)= 0.445948490915965;
                s(6,2)= 0.445948490915965;
                wt(1:3)=0.109951743655322;
                wt(4:6)=0.223381589678011;
                wt=0.5*wt;
            case 7        % order 7, degree of precision 5.
                s(1,1)= 0.333333333333333;
                s(1,2)= 0.333333333333333;
                s(2,1)= 0.797426985353087;
                s(2,2)= 0.101286507323456;
                s(3,1)= 0.101286507323456;
                s(3,2)= 0.797426985353087;
                s(4,1)= 0.101286507323456;
                s(4,2)= 0.101286507323456;
                s(5,1)= 0.470142064105115;
                s(5,2)= 0.059715871789770;
                s(6,1)= 0.059715871789770;
                s(6,2)= 0.470142064105115;
                s(7,1)= 0.470142064105115;
                s(7,2)= 0.470142064105115;
                wt(1) = 0.225000000000000;
                wt(2:4)=0.125939180544827;
                wt(5:7)=0.132394152788506;
                wt=0.5*wt;
                
            case 9 % order 9, degree of precision 6.
                
                s= [0.124949503233232  0.437525248383384; ...
                    0.437525248383384  0.124949503233232; ...
                    0.437525248383384  0.437525248383384; ...
                    0.797112651860071  0.165409927389841; ...
                    0.797112651860071  0.037477420750088; ...
                    0.165409927389841  0.797112651860071; ...
                    0.165409927389841  0.037477420750088; ...
                    0.037477420750088  0.797112651860071; ...
                    0.037477420750088  0.165409927389841];
                
                wt=[0.205950504760887 ...
                    0.205950504760887 ...
                    0.205950504760887 ...
                    0.063691414286223 ...
                    0.063691414286223 ...
                    0.063691414286223 ...
                    0.063691414286223 ...
                    0.063691414286223 ...
                    0.063691414286223 ];
                wt=0.5*wt;
                
                
            case 12   % order 12, degree of precision 6.
                s(1,1)= 0.873821971016996;
                s(1,2)= 0.063089014491502;
                s(2,1)= 0.063089014491502;
                s(2,2)= 0.873821971016996;
                s(3,1)= 0.063089014491502;
                s(3,2)= 0.063089014491502;
                s(4,1)= 0.501426509658179;
                s(4,2)= 0.249286745170910;
                s(5,1)= 0.249286745170910;
                s(5,2)= 0.501426509658179;
                s(6,1)= 0.249286745170910;
                s(6,2)= 0.249286745170910;
                s(7,1) =0.053145049844817;
                s(7,2) =0.310352451033784;
                s(8,1) =0.310352451033784;
                s(8,2) =0.053145049844817;
                s(9,1) =0.053145049844817;
                s(9,2) =0.636502499121398;
                s(10,1)=0.310352451033784;
                s(10,2)=0.636502499121398;
                s(11,1)=0.636502499121398;
                s(11,2)=0.053145049844817;
                s(12,1)=0.636502499121398;
                s(12,2)=0.310352451033784;
                wt(1:3)=0.050844906370207;
                wt(4:6)=0.116786275726379;
                wt(7:12)=0.082851075618374;
                wt=0.5*wt;
                
            case 13  % order 13, degree of precision 7.
                
                s=[ 0.333333333333333  0.333333333333333 ; ...
                    0.479308067841923  0.260345966079038 ; ...
                    0.260345966079038  0.479308067841923 ; ...
                    0.260345966079038  0.260345966079038 ; ...
                    0.869739794195568  0.065130102902216 ; ...
                    0.065130102902216  0.869739794195568 ; ...
                    0.065130102902216  0.065130102902216 ; ...
                    0.638444188569809  0.312865496004875 ; ...
                    0.638444188569809  0.048690315425316 ; ...
                    0.312865496004875  0.638444188569809 ; ...
                    0.312865496004875  0.048690315425316 ; ...
                    0.048690315425316  0.638444188569809 ; ...
                    0.048690315425316  0.312865496004875 ];
                wt= [ -0.149570044467670 ; ...
                    0.175615257433204 ; ...
                    0.175615257433204 ; ...
                    0.175615257433204 ; ...
                    0.053347235608839 ; ...
                    0.053347235608839 ; ...
                    0.053347235608839 ; ...
                    0.077113760890257 ; ...
                    0.077113760890257 ; ...
                    0.077113760890257 ; ...
                    0.077113760890257 ; ...
                    0.077113760890257 ; ...
                    0.077113760890257 ];
                wt=0.5*wt;
                
            case 16
                s(1,1)=0.333333333333333;
                s(1,2)=0.333333333333333;
                s(2,1)=0.658861384496478;
                s(2,2)=0.170569307751761;
                s(3,1)=0.170569307751761;
                s(3,2)=0.658861384496478;
                s(4,1)=0.170569307751761;
                s(4,2)=0.170569307751761;
                s(5,1)=0.898905543365938;
                s(5,2)=0.050547228317031;
                s(6,1)=0.050547228317031;
                s(6,2)=0.898905543365938;
                s(7,1)=0.050547228317031;
                s(7,2)=0.050547228317031;
                s(8,1)=0.081414823414554;
                s(8,2)=0.459292588292723;
                s(9,1)=0.459292588292723;
                s(9,2)=0.081414823414554;
                s(10,1)=0.459292588292723;
                s(10,2)=0.459292588292723;
                s(11,1)=0.008394777409958;
                s(11,2)=0.263112829634638;
                s(12,1)=0.008394777409958;
                s(12,2)=0.728492392955404;
                s(13,1)=0.263112829634638;
                s(13,2)=0.008394777409958;
                s(14,1)=0.263112829634638;
                s(14,2)=0.728492392955404;
                s(15,1)=0.728492392955404;
                s(15,2)=0.008394777409958;
                s(16,1)=0.728492392955404;
                s(16,2)=0.263112829634638;
                wt(1)=0.144315607677787;
                wt(2:4)=0.103217370534718;
                wt(5:7)=0.032458497623198;
                wt(8:10)=0.095091634267284;
                wt(11:16)=0.027230314174435;
                wt=0.5*wt;
                
            case 19 % order 19, degree of precision 9,
                
                
                s=[0.33333333333333331       0.33333333333333331      ; ...
                    2.06349616025259287E-002  0.48968251919873701      ; ...
                    0.48968251919873701       2.06349616025259287E-002 ; ...
                    0.48968251919873701       0.48968251919873701      ; ...
                    0.12582081701412900       0.43708959149293553      ; ...
                    0.43708959149293553       0.12582081701412900      ; ...
                    0.43708959149293553       0.43708959149293553      ; ...
                    0.62359292876193562       0.18820353561903219      ; ...
                    0.18820353561903219       0.62359292876193562      ; ...
                    0.18820353561903219       0.18820353561903219      ; ...
                    0.91054097321109406       4.47295133944529688E-002 ; ...
                    4.47295133944529688E-002  0.91054097321109406      ; ...
                    4.47295133944529688E-002  4.47295133944529688E-002 ; ...
                    0.74119859878449801       3.68384120547362581E-002 ; ...
                    0.74119859878449801       0.22196298916076573      ; ...
                    3.68384120547362581E-002  0.74119859878449801      ; ...
                    3.68384120547362581E-002  0.22196298916076573      ; ...
                    0.22196298916076573       0.74119859878449801      ; ...
                    0.22196298916076573       3.68384120547362581E-002 ];
                
                
                
                wt= [9.71357962827961025E-002 ; ...
                    3.13347002271398278E-002 ; ...
                    3.13347002271398278E-002 ; ...
                    3.13347002271398278E-002 ; ...
                    7.78275410047754301E-002 ; ...
                    7.78275410047754301E-002 ; ...
                    7.78275410047754301E-002 ; ...
                    7.96477389272090969E-002 ; ...
                    7.96477389272090969E-002 ; ...
                    7.96477389272090969E-002 ; ...
                    2.55776756586981006E-002 ; ...
                    2.55776756586981006E-002 ; ...
                    2.55776756586981006E-002 ; ...
                    4.32835393772893970E-002 ; ...
                    4.32835393772893970E-002 ; ...
                    4.32835393772893970E-002 ; ...
                    4.32835393772893970E-002 ; ...
                    4.32835393772893970E-002 ; ...
                    4.32835393772893970E-002 ];
                wt=0.5*wt;
                
            case 28 % order 28, degree of precision 11,
                s=[ 0.33333333333333333  0.333333333333333333 ; ...
                    0.9480217181434233   0.02598914092828833 ; ...
                    0.02598914092828833  0.9480217181434233 ; ...
                    0.02598914092828833  0.02598914092828833 ; ...
                    0.8114249947041546   0.09428750264792270 ; ...
                    0.09428750264792270  0.8114249947041546 ; ...
                    0.09428750264792270  0.09428750264792270 ; ...
                    0.01072644996557060  0.4946367750172147 ; ...
                    0.4946367750172147   0.01072644996557060 ; ...
                    0.4946367750172147   0.4946367750172147 ; ...
                    0.5853132347709715   0.2073433826145142 ; ...
                    0.2073433826145142   0.5853132347709715 ; ...
                    0.2073433826145142   0.2073433826145142 ; ...
                    0.1221843885990187   0.4389078057004907 ; ...
                    0.4389078057004907   0.1221843885990187 ; ...
                    0.4389078057004907   0.4389078057004907 ; ...
                    0.6779376548825902   0.04484167758913055 ; ...
                    0.6779376548825902   0.27722066752827925 ; ...
                    0.04484167758913055  0.6779376548825902 ; ...
                    0.04484167758913055  0.27722066752827925 ; ...
                    0.27722066752827925  0.6779376548825902 ; ...
                    0.27722066752827925  0.04484167758913055 ; ...
                    0.8588702812826364   0.00000000000000000 ; ...
                    0.8588702812826364   0.1411297187173636 ; ...
                    0.0000000000000000   0.8588702812826364 ; ...
                    0.0000000000000000   0.1411297187173636 ; ...
                    0.1411297187173636   0.8588702812826364 ; ...
                    0.1411297187173636   0.0000000000000000 ] ;
                
                
                wt = [ 0.08797730116222190 ; ...
                    0.008744311553736190 ; ...
                    0.008744311553736190 ; ...
                    0.008744311553736190 ; ...
                    0.03808157199393533 ; ...
                    0.03808157199393533 ; ...
                    0.03808157199393533 ; ...
                    0.01885544805613125 ; ...
                    0.01885544805613125 ; ...
                    0.01885544805613125 ; ...
                    0.07215969754474100 ; ...
                    0.07215969754474100 ; ...
                    0.07215969754474100 ; ...
                    0.06932913870553720 ; ...
                    0.06932913870553720 ; ...
                    0.06932913870553720 ; ...
                    0.04105631542928860 ; ...
                    0.04105631542928860 ; ...
                    0.04105631542928860 ; ...
                    0.04105631542928860 ; ...
                    0.04105631542928860 ; ...
                    0.04105631542928860 ; ...
                    0.007362383783300573 ; ...
                    0.007362383783300573 ; ...
                    0.007362383783300573 ; ...
                    0.007362383783300573 ; ...
                    0.007362383783300573 ; ...
                    0.007362383783300573 ];
                
                wt=0.5*wt;
                
            case 37  % order 37, degree of precision 13
                s = [ 0.333333333333333333333333333333  0.333333333333333333333333333333 ; ...
                    0.950275662924105565450352089520  0.024862168537947217274823955239 ; ...
                    0.024862168537947217274823955239  0.950275662924105565450352089520 ; ...
                    0.024862168537947217274823955239  0.024862168537947217274823955239 ; ...
                    0.171614914923835347556304795551  0.414192542538082326221847602214 ; ...
                    0.414192542538082326221847602214  0.171614914923835347556304795551 ; ...
                    0.414192542538082326221847602214  0.414192542538082326221847602214 ; ...
                    0.539412243677190440263092985511  0.230293878161404779868453507244 ; ...
                    0.230293878161404779868453507244  0.539412243677190440263092985511 ; ...
                    0.230293878161404779868453507244  0.230293878161404779868453507244 ; ...
                    0.772160036676532561750285570113  0.113919981661733719124857214943 ; ...
                    0.113919981661733719124857214943  0.772160036676532561750285570113 ; ...
                    0.113919981661733719124857214943  0.113919981661733719124857214943 ; ...
                    0.009085399949835353883572964740  0.495457300025082323058213517632 ; ...
                    0.495457300025082323058213517632  0.009085399949835353883572964740 ; ...
                    0.495457300025082323058213517632  0.495457300025082323058213517632 ; ...
                    0.062277290305886993497083640527  0.468861354847056503251458179727 ; ...
                    0.468861354847056503251458179727  0.062277290305886993497083640527 ; ...
                    0.468861354847056503251458179727  0.468861354847056503251458179727 ; ...
                    0.022076289653624405142446876931  0.851306504174348550389457672223 ; ...
                    0.022076289653624405142446876931  0.126617206172027096933163647918 ; ...
                    0.851306504174348550389457672223  0.022076289653624405142446876931 ; ...
                    0.851306504174348550389457672223  0.126617206172027096933163647918 ; ...
                    0.126617206172027096933163647918  0.022076289653624405142446876931 ; ...
                    0.126617206172027096933163647918  0.851306504174348550389457672223 ; ...
                    0.018620522802520968955913511549  0.689441970728591295496647976487 ; ...
                    0.018620522802520968955913511549  0.291937506468887771754472382212 ; ...
                    0.689441970728591295496647976487  0.018620522802520968955913511549 ; ...
                    0.689441970728591295496647976487  0.291937506468887771754472382212 ; ...
                    0.291937506468887771754472382212  0.018620522802520968955913511549 ; ...
                    0.291937506468887771754472382212  0.689441970728591295496647976487 ; ...
                    0.096506481292159228736516560903  0.635867859433872768286976979827 ; ...
                    0.096506481292159228736516560903  0.267625659273967961282458816185 ; ...
                    0.635867859433872768286976979827  0.096506481292159228736516560903 ; ...
                    0.635867859433872768286976979827  0.267625659273967961282458816185 ; ...
                    0.267625659273967961282458816185  0.096506481292159228736516560903 ; ...
                    0.267625659273967961282458816185  0.635867859433872768286976979827 ];
                
                
                wt=[ 0.051739766065744133555179145422 ; ...
                    0.008007799555564801597804123460 ; ...
                    0.008007799555564801597804123460 ; ...
                    0.008007799555564801597804123460 ; ...
                    0.046868898981821644823226732071 ; ...
                    0.046868898981821644823226732071 ; ...
                    0.046868898981821644823226732071 ; ...
                    0.046590940183976487960361770070 ; ...
                    0.046590940183976487960361770070 ; ...
                    0.046590940183976487960361770070 ; ...
                    0.031016943313796381407646220131 ; ...
                    0.031016943313796381407646220131 ; ...
                    0.031016943313796381407646220131 ; ...
                    0.010791612736631273623178240136 ; ...
                    0.010791612736631273623178240136 ; ...
                    0.010791612736631273623178240136 ; ...
                    0.032195534242431618819414482205 ; ...
                    0.032195534242431618819414482205 ; ...
                    0.032195534242431618819414482205 ; ...
                    0.015445834210701583817692900053 ; ...
                    0.015445834210701583817692900053 ; ...
                    0.015445834210701583817692900053 ; ...
                    0.015445834210701583817692900053 ; ...
                    0.015445834210701583817692900053 ; ...
                    0.015445834210701583817692900053 ; ...
                    0.017822989923178661888748319485 ; ...
                    0.017822989923178661888748319485 ; ...
                    0.017822989923178661888748319485 ; ...
                    0.017822989923178661888748319485 ; ...
                    0.017822989923178661888748319485 ; ...
                    0.017822989923178661888748319485 ; ...
                    0.037038683681384627918546472190 ; ...
                    0.037038683681384627918546472190 ; ...
                    0.037038683681384627918546472190 ; ...
                    0.037038683681384627918546472190 ; ...
                    0.037038683681384627918546472190 ; ...
                    0.037038683681384627918546472190 ];
                wt=0.5*wt ;
                
                
                
            otherwise
                disp('wrong number of integrating points for a triangle')
                error('sfda')
        end
    case 'quadrilateral'
        switch nip
            case 1
                s(1,1)=0.0;
                s(1,2)=0.0;
                wt(1)=4.0;
            case 4
                s(1,1)=-root3;
                s(1,2)= root3;
                s(2,1)= root3;
                s(2,2)= root3;
                s(3,1)=-root3;
                s(3,2)=-root3;
                s(4,1)= root3;
                s(4,2)=-root3;
                wt(1:4)=1.0;   % ghg
            case 9
                s(1:3:7,1)=-r15; % ghg
                s(2:3:8,1)=0.0;   % ghg
                s(3:3:9,1)=r15;   % ghg
                s(1:3,2)  =r15;
                s(4:6,2)  =0.0;
                s(7:9,2)  =-r15;
                wt= v;
            case 16 % ghg
                s(1:4:13,1)=-0.861136311594053;
                s(2:4:14,1)=-0.339981043584856;
                s(3:4:15,1)= 0.339981043584856;
                s(4:4:16,1)= 0.861136311594053;
                s(1:4,2)   = 0.861136311594053;
                s(5:8,2)   = 0.339981043584856;
                s(9:12,2)  =-0.339981043584856;
                s(13:16,2) =-0.861136311594053;
                wt(1)      = 0.121002993285602;
                wt(4)      = wt(1);
                wt(13)     = wt(1);
                wt(16)     = wt(1);
                wt(2)      = 0.226851851851852;
                wt(3)      = wt(2);
                wt(5)      = wt(2);
                wt(8)      = wt(2);
                wt(9)      = wt(2);
                wt(12)     = wt(2);
                wt(14)     = wt(2);
                wt(15)     = wt(2);
                wt(6)      = 0.425293303010694;
                wt(7)      = wt(6);
                wt(10)     = wt(6);
                wt(11)     = wt(6);
            case 25 % ghg
                s(1:5:21,1)= 0.906179845938664;
                s(2:5:22,1)= 0.538469310105683;
                s(3:5:23,1)= 0.0;
                s(4:5:24,1)=-0.538469310105683;
                s(5:5:25,1)=-0.906179845938664;
                s( 1: 5,2) = 0.906179845938664;
                s( 6:10,2) = 0.538469310105683;
                s(11:15,2) = 0.0;
                s(16:20,2) =-0.538469310105683;
                s(21:25,2) =-0.906179845938664;
                wt(1) =0.056134348862429;
                wt(2) =0.113400000000000;
                wt(3) =0.134785072387521;
                wt(4) =0.113400000000000;
                wt(5) =0.056134348862429;
                wt(6) =0.113400000000000;
                wt(7) =0.229085404223991;
                wt(8) =0.272286532550750;
                wt(9) =0.229085404223991;
                wt(10)=0.113400000000000;
                wt(11)=0.134785072387521;
                wt(12)=0.272286532550750;
                wt(13)=0.323634567901235;
                wt(14)=0.272286532550750;
                wt(15)=0.134785072387521;
                wt(16)=0.113400000000000;
                wt(17)=0.229085404223991;
                wt(18)=0.272286532550750;
                wt(19)=0.229085404223991;
                wt(20)=0.113400000000000;
                wt(21)=0.056134348862429;
                wt(22)=0.113400000000000;
                wt(23)=0.134785072387521;
                wt(24)=0.113400000000000;
                wt(25)=0.056134348862429;
            otherwise
                disp('wrong number of integrating points for a quadrilateral')
        end
    case 'tetrahedron'
        %                      for tetrahedra weights multiplied by 1/6
        switch nip
            case 1
                s(1,1)=0.25;
                s(1,2)=0.25;
                s(1,3)=0.25;
                wt(1)=1.0/6.0;
            case 4
                s(1,1)=0.58541020;
                s(1,2)=0.13819660;
                s(1,3)=s(1,2);
                s(2,2)=s(1,1);
                s(2,3)=s(1,2);
                s(2,1)=s(1,2);
                s(3,3)=s(1,1);
                s(3,1)=s(1,2);
                s(3,2)=s(1,2);
                s(4,1)=s(1,2);
                s(4,2)=s(1,2);
                s(4,3)=s(1,2);
                wt(1:4)=0.25/6.0;
            case 5
                s(1,1)=0.25;
                s(1,2)=0.25;
                s(1,3)=0.25;
                s(2,1)=0.5;
                s(2,2)=1.0/6.0;
                s(2,3)=s(2,2);
                s(3,2)=0.5;
                s(3,3)=1.0/6.0;
                s(3,1)=s(3,3);
                s(4,3)=0.5;
                s(4,1)=1.0/6.0;
                s(4,2)=s(4,1);
                s(5,1)=1.0/6.0;
                s(5,2)=s(5,1);
                s(5,3)=s(5,1);
                wt(1)=-0.8;
                wt(2)=9.0/20.0;
                wt(3:5)=wt(2);
                wt=wt/6.0;
            otherwise
                disp('wrong number of integrating points for a tetrahedron')
        end
    case 'hexahedron'
        switch nip
            case 1
                s(1,1:3)=0.0;
                wt(1)=8.0;
            case 8
                s(1,1)= root3;
                s(1,2)= root3;
                s(1,3)= root3;
                s(2,1)= root3;
                s(2,2)= root3;
                s(2,3)=-root3;
                s(3,1)= root3;
                s(3,2)=-root3;
                s(3,3)= root3;
                s(4,1)= root3;
                s(4,2)=-root3;
                s(4,3)=-root3;
                s(5,1)=-root3;
                s(5,2)= root3;
                s(5,3)= root3;
                s(6,1)=-root3;
                s(6,2)=-root3;
                s(6,3)= root3;
                s(7,1)=-root3;
                s(7,2)= root3;
                s(7,3)=-root3;
                s(8,1)=-root3;
                s(8,2)=-root3;
                s(8,3)=-root3;
                wt(1:8)=1.0;
            case 14
                b=0.795822426;
                c=0.758786911;
                wt(1:6)=0.886426593;
                wt(7:14)=0.335180055;
                s(1,1)=-b;
                s(2,1)=b;
                s(3,2)=-b;
                s(4,2)=b;
                s(5,3)=-b;
                s(6,3)=b;
                s(7:end,:)=c;  % ghg
                s(7,1)=-c;
                s(7,2)=-c;
                s(7,3)=-c;
                s(8,2)=-c;
                s(8,3)=-c;
                s(9,1)=-c;
                s(9,3)=-c;
                s(10,3)=-c;
                s(11,1)=-c;
                s(11,2)=-c;
                s(12,2)=-c;
                s(13,1)=-c;
            case 15
                b=1.0;
                c       =0.674199862;
                wt(1)   =1.564444444;
                wt(2:7) =0.355555556;
                wt(8:15)=0.537777778;
                s(2,1)=-b;
                s(3,1)=b;
                s(4,2)=-b;
                s(5,2)=b;
                s(6,3)=-b;
                s(7,3)=b;
                s(8:end,:)=c; % ghg
                s(8,1)=-c;
                s(8,2)=-c;
                s(8,3)=-c;
                s(9,2)=-c;
                s(9,3)=-c;
                s(10,1)=-c;
                s(10,3)=-c;
                s(11,3)=-c;
                s(12,1)=-c;
                s(12,2)=-c;
                s(13,2)=-c;
                s(14,1)=-c;
            case 27 % ghg
                wt=[5.0/9.0*v,8.0/9.0*v,5.0/9.0*v];
                s(1:3:7,1)=-r15;
                s(2:3:8,1)=0.0;
                s(3:3:9,1)=r15;
                s(1:3,3)=r15;
                s(4:6,3)=0.0;
                s(7:9,3)=-r15;
                s(1:9,2)=-r15;
                s(10:3:16,1)=-r15;
                s(11:3:17,1)=0.0;
                s(12:3:18,1)=r15;
                s(10:12,3)=r15;
                s(13:15,3)=0.0;
                s(16:18,3)=-r15;
                s(10:18,2)=0.0;
                s(19:3:25,1)=-r15;
                s(20:3:26,1)=0.0;
                s(21:3:27,1)=r15;
                s(19:21,3)= r15;
                s(22:24,3)=0.0;
                s(25:27,3)=-r15;
                s(19:27,2)= r15;
            otherwise
                disp('wrong number of integrating points for a hexahedron')
        end
    otherwise
        disp('not a valid element type')
end
end

