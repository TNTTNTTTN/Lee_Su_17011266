classdef Satellite
    properties
        ecefdataset
        geodataset
        enudataset
        wgs84
        mu
        timestep
        M0
        t0
        a
        e
        i
        omega
        OMEGA
    end
    
    methods
        function obj = Satellite(navdata, timestep)
            obj.wgs84 = wgs84Ellipsoid('kilometer');
            obj.mu = 3.986004418*10^5; % [km^3/sec^2]
            obj.t0 = datetime(navdata.toc);
            obj.M0 = navdata.M0;
            obj.a = navdata.a;
            obj.e = navdata.e;
            obj.i = navdata.i;
            obj.omega = navdata.omega;
            obj.OMEGA = navdata.OMEGA;
            obj.timestep = timestep; % [sec]
            obj.ecefdataset = Set_ecef(obj);
            obj.geodataset = Set_geo(obj);
            obj.enudataset = [];
        end
        function ECEF = Set_ecef(obj)
            ECEF = [];
            timerange = 5*24*3600/obj.timestep; % split 5 days by timestep
            for k = 0:timerange
                M = rem(obj.M0 + sqrt(obj.mu/((obj.a/1000)^3)) * ...
                    (seconds(datetime([2023, 06, 01, 12, 00, 00]) - obj.t0) + obj.timestep*k), 2*pi);
                nu = E2T(M2E(M, obj.e), obj.e)*180/pi;
                R = solveRangeInPerifocalFrame(obj.a/1000, obj.e, nu);
                R_eci = PQW2ECI(obj.omega*180/pi, obj.i*180/pi, obj.OMEGA*180/pi)*R;
                R_ecef = ECI2ECEF_DCM(datetime([2023, 06, 01, 12, 00, 00])+seconds(obj.timestep)*k)*R_eci;
                ECEF = [ECEF; R_ecef'];
            end
        end
        function GEODETIC = Set_geo(obj)
            [q1,q2,q3] = ecef2geodetic(obj.wgs84, obj.ecefdataset(:,1), obj.ecefdataset(:,2), obj.ecefdataset(:,3));
            GEODETIC = [q1, q2, q3];
        end
        function obj = Set_enu(obj, Ground)
            [E, N, U] = ecef2enu(obj.ecefdataset(:,1), obj.ecefdataset(:,2), obj.ecefdataset(:,3), Ground(1), Ground(2), Ground(3), obj.wgs84);
            obj.enudataset = [E,N,U];
        end
    end
end

