%RAFIK BADILAH_L0325009
%RESPONSI 1_PRAKTIKUM METODE NUMERIK

% ==========================================
% KASUS 3: Persamaan Non-Linier
% ==========================================

% Definisi Fungsi Non-Linier f(r) = (4/3)*pi*r^3 - 300
f = @(r) (4/3) * pi * (r.^3) - 300;

% 1. Penentuan Nilai Awal via Metode Grafik
r_vals = linspace(0, 10, 200);
figure;
plot(r_vals, f(r_vals), 'b-', 'LineWidth', 2); hold on;
plot([0 10], [0 0], 'r--', 'LineWidth', 1.5); % Garis y = 0
xlabel('r (cm)');
ylabel('f(r)');
title('Grafik Persamaan Non-Linier f(r) = 4/3 * pi * r^3 - 300');
grid on;

% Dari grafik terlihat akar berada di antara r = 3 dan r = 5.
a = 3;
b = 5;
tol = 1e-5;
max_iter = 100;

% 2. Metode Biseksi
fprintf('=== METODE BISEKSI (KASUS 3) ===\n');
iter = 0;
c = a;

while (b - a)/2 > tol && iter < max_iter
    iter = iter + 1;
    c = (a + b) / 2;

    if f(c) == 0
        break;
    elseif f(a) * f(c) < 0
        b = c;
    else
        a = c;
    end
end

r_sol = c;
fprintf('Jari-jari bola/tabung (r) = %.5f cm\n', r_sol);
fprintf('Jumlah Iterasi            = %d\n\n', iter);

% 3. Perhitungan Volume Bagian Tabung di luar Bola
% V_tabung = pi * r^2 * t, dengan t = 2r => V_tabung = 2 * pi * r^3
% V_luar = V_tabung - V_bola = 2*pi*r^3 - 300 = (2/3)*pi*r^3
V_luar = (2/3) * pi * (r_sol^3);
fprintf('=== HASIL VOLUME TABUNG DI LUAR BOLA ===\n');
fprintf('Volume Tabung di Luar Bola (V) = %.4f cm^3\n', V_luar);
