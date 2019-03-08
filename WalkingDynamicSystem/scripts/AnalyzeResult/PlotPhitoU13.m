%%
[MatFile,MatFolder] = ...
    uigetfile('*.mat','Pick the file');
load([MatFolder filesep MatFile]);

%%
figure();
for ii = 1 : 6
    hold on;
    plot(t(SgStartNum(ii):SgEndNum(ii)),fun(u(SgStartNum(ii):SgEndNum(ii),13)),'LineWidth',2);
end
grid on;
%%
for ii = 1 : 6000

[ xf(ii,:),xf_dot(ii,:),yf(ii,:),yf_dot(ii,:) ] = HeelAndToe( x(ii,:)',x_dot(ii,:)',y(ii,:)',y_dot(ii,:)',theta(ii,:)',theta_dot(ii,:)' );

[ Fgy(ii,:) ] = GroundReactionForceY( x(ii,:)',theta(ii,:)',xf(ii,:),xf_dot(ii,:),yf(ii,:),yf_dot(ii,:) );
% [ Fgx(ii,:),Fgy(ii,:) ] = GroundReactionForce( x(ii,:)',theta(ii,:)',xf(ii,:),xf_dot(ii,:),yf(ii,:),yf_dot(ii,:) );

[ phi(ii,:),phi_dot(ii,:) ] = GlobalAngle( x(ii,:)',x_dot(ii,:)',y(ii,:)',y_dot(ii,:)',theta(ii,:)',Fgy(ii,:) );

end
%%
figure();
for ii = 1 : 6
    hold on;
    plot(t(SgStartNum(ii):SgEndNum(ii)),(phi(SgStartNum(ii):SgEndNum(ii))),'LineWidth',2);
end
grid on;
%%
figure();
for ii = [2,3]
    subplot(2,1,1);
    hold on;
    plot(phi(SgStartNum(ii):SgEndNum(ii)),fun(u(SgStartNum(ii):SgEndNum(ii),13)));
end
grid on;

for ii = [5,6]
    subplot(2,1,2);
    hold on;
    plot(phi(SgStartNum(ii):SgEndNum(ii)),fun(u(SgStartNum(ii):SgEndNum(ii),13)));
end
grid on;

%%
for ii = 1 : 6
    PhiToU13{ii} = [phi(SgStartNum(ii):SgEndNum(ii)),(u(SgStartNum(ii):SgEndNum(ii),13))];
end