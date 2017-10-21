import numpy as np

class Simulator(object):
    def __init__(self):
        self.names = ['A', 'B', 'C', 'D', 'E']

        # Prepare initial conditions
        self.A = [100]
        self.B = [10]
        self.C = [2]
        self.D = [5]
        self.E = [1]

        self.k1 = 0.1
        self.k2 = 1.0
        self.k3 = 5.0
        self.k4 = 2.0
        self.k5 = 10.

        self.v1 = []
        self.v2 = []
        self.v3 = []
        self.v4 = []
        self.v5 = []

        self.dt = 0.01
        self.time = 0
        self.times = [self.time]

        self.calculate_kinetics()

    def calculate_kinetics(self):
        v1 = self.k1 * self.A[-1]
        self.v1.append(v1)
        v2 = self.k2 * self.B[-1]
        self.v2.append(v2)
        v3 = self.k3 * self.C[-1]
        self.v3.append(v3)
        v4 = self.k4 * self.D[-1]
        self.v4.append(v4)
        v5 = self.k5 * self.E[-1]
        self.v5.append(v5)

    def take_step(self):
        # Increment stezenia
        dA = 0
        dB = (self.v1[-1] - self.v2[-1]) * self.dt
        dC = (self.v2[-1] - self.v3[-1]) * self.dt
        dD = (self.v3[-1] - self.v4[-1]) * self.dt
        dE = (self.v4[-1] - self.v5[-1]) * self.dt

        self.A.append(self.A[-1] + dA)
        self.B.append(self.B[-1] + dB)
        self.C.append(self.C[-1] + dC)
        self.D.append(self.D[-1] + dD)
        self.E.append(self.E[-1] + dE)

        self.calculate_kinetics()

        self.time += self.dt
        self.times.append(self.time)

    def go_to(self, time):
        while time > self.time:
            self.take_step()

