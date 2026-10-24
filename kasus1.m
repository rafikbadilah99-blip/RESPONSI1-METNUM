%RAFIK BADILAH_L0325009
%RESPONSI 1_PRAKTIKUM METODE NUMERIK

% ==========================================
% KASUS 1: Galat & Error Pemotongan
% ==========================================

% Parameter
h0 = 5;
lambda = 12;
v = 36;
x_val = 10;
t = linspace(0, 5, 100); % Rentang 0 <= t <= 5

% 1. Perhitungan Eksak
h_eksak = h0 * (cos(t * v / lambda) + exp(x_val));

% Fungsi Pendekatan Cosine dan Exp
% cos(u) = sum_{k=0}^{N} (-1)^k * u^(2k) / (2k)!
% exp(u) = sum_{k=0}^{N} u^k / k!

function c = approx_cos(u, n_terms)
    c = zeros(size(u));
    for k = 0:(n_terms-1)
        c = c + ((-1)^k) * (u.^(2*k)) / factorial(2*k);
    end
end

function e = approx_exp(u, n_terms)
    e = 0;
    for k = 0:(n_terms-1)
        e = e + (u^k) / factorial(k);
    end
end

% 2. Perhitungan Pendekatan untuk n = 23, 24, 25
n_vals = [23, 24, 25];
h_app = zeros(length(n_vals), length(t));

for i = 1:length(n_vals)
    n = n_vals(i);
    cos_app = approx_cos(t * v / lambda, n);
    exp_app = approx_exp(x_val, n);
    h_app(i, :) = h0 * (cos_app + exp_app);
end

% 3. Plot Grafik Perbandingan
figure;
plot(t, h_eksak, 'k-', 'LineWidth', 2, 'DisplayName', 'Eksak'); hold on;
plot(t, h_app(1,:), 'r--', 'LineWidth', 1.5, 'DisplayName', 'Pendekatan n=23');
plot(t, h_app(2,:), 'g-.', 'LineWidth', 1.5, 'DisplayName', 'Pendekatan n=24');
plot(t, h_app(3,:), 'b:', 'LineWidth', 1.5, 'DisplayName', 'Pendekatan n=25');
xlabel('t (waktu)');
ylabel('h (tinggi gelombang)');
title('Perbandingan Perhitungan Eksak vs Pendekatan (Kasus 1)');
legend('Location', 'northeastoutside');
grid on;

% 4. Perhitungan Rerata Galat Mutlak & Analisis Toleransi Error (1%)
fprintf('=== ANALISIS GALAT KASUS 1 ===\n');
for i = 1:length(n_vals)
    galat_mutlak = abs(h_eksak - h_app(i,:));
    rerata_galat = mean(galat_mutlak);

    % Galat relatif persentase
    galat_relatif_pct = mean(galat_mutlak ./ abs(h_eksak)) * 100;

    fprintf('n = %d | Rerata Galat Mutlak: %.4f | Rerata Galat Relatif: %.4f%%\n', ...
        n_vals(i), rerata_galat, galat_relatif_pct);
end

% Keputusan Layak / Tidak
% Jika galat relatif < 1%, maka layak.
