figure(1)
plot(referencia,'-b','LineWidth',1)
hold on
plot(funcion_cost,'--g','LineWidth',1)
hold on
plot(f_c_estandar,'--r','LineWidth',1)
hold on
plot(f_c_estandar_ruido,'-.m','LineWidth',1)

hold on
plot(f_c_OneShot,'--k','LineWidth',1)
hold on
plot(f_c_OneShot_ruido,'-.y','LineWidth',1)

xlabel('Tiempo(s)')
ylabel('unidades')
legend({'Referencia','Algoritmo Propuesto','Control estándar con ruido','Control estándar sin ruido','Controlador con señal de control actualizada sin ruido','Controlador con señal de control actualizada con ruido'},'Location','southeast ')