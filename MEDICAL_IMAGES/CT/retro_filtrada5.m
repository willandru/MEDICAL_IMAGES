% retroproyeccion filtrada
bpf_recon = zeros(nx,ny);
for ia = 1:na
 disp(sprintf('angulo %g de %g', ia, na));
 bpf_ia=sinogramfilt(:,ia);
 bpf_smear=repmat(bpf_ia,1,128);
 % rotando la proyeccion
 rot1= imrotate(bpf_smear', ia*180/256, 'bicubic','crop');
 bpf_recon=bpf_recon+rot1;
end
% visualizar la imagen reconstruida
figure(6)
 imagesc(x, y, max(bpf_recon,0));
 colormap('gray');
 axis('image')
 title('Reconstruccion por retroproyeccion filtrada')
 xlabel('Posicion x')
 ylabel('Posicion y')
